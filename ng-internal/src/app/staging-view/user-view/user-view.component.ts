
// Import vendor modules.
import { ActivatedRoute } from "@angular/router";
import { Component } from "@angular/core";
import { inject } from "@angular/core";
import { Router } from "@angular/router";
import { RouterLink } from "@angular/router";

// Import app modules.
import { ApiClient } from "~/app/shared/services/api-client";
import { Demo } from "~/app/shared/types";
import { ErrorService } from "~/app/shared/services/error.service";
import { ExpiredResponseError } from "~/app/shared/services/error.service";
import { SpinnerComponent } from "~/app/shared/components/spinner/spinner.component";
import { WindowTitle } from "~/app/shared/services/window-title";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

interface RouteInputs {
	userID: number;
};

interface Partial {
	user: Demo.User;
	features: Demo.Feature[];
	environments: Demo.Environment[];
	breakdown: Breakdown;
};

interface Breakdown {
	[ featureKey: string ]: {
		[ environmentKey: string ]: {
			variantIndex: number;
			variant: string; // Serialized on the server.
		};
	};
};

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

var LAST_RESPONSE_ID = 0;

@Component({
	selector: "staging-user-view",
	standalone: true,
	imports: [
		RouterLink,
		SpinnerComponent
	],
	styleUrl: "./user-view.component.less",
	templateUrl: "./user-view.component.html"
})
export class UserViewComponent {

	private activatedRoute = inject( ActivatedRoute );
	private apiClient = inject( ApiClient );
	private errorService = inject( ErrorService );
	private router = inject( Router );
	private windowTitle = inject( WindowTitle );

	public routeInputs: RouteInputs = {
		userID: 0
	};
	public isLoading = true;
	public user: Demo.User | null = null;
	public features: Demo.Feature[] = [];
	public environments: Demo.Environment[] = [];
	public breakdown: Breakdown = {};

	// ---
	// LIFE-CYCLE METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "User Staging" );
		this.activatedRoute.params.subscribe( this.handleActivatedRouteChange );

	}


	/**
	* I get called once when the component is being torn down.
	*/
	public ngOnDestroy() {

		// When the component is destroyed, we want to change the last response ID so that
		// any pending data load will be ignored.
		LAST_RESPONSE_ID++;

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I gather all of the relevant URL-provided data, using sane defaults if no relevant
	* value is present in the URL.
	*/
	private getRouteInputs() : RouteInputs {

		var snapshot = this.activatedRoute.snapshot;

		return {
			userID: ( + snapshot.params.userID || 0 )
		};

	}


	/**
	* I handle changes to the activated route, updating the view-model as necessary.
	*/
	private handleActivatedRouteChange = () => {

		var currentInputs = this.getRouteInputs();

		if ( currentInputs.userID !== this.routeInputs.userID ) {

			this.routeInputs = currentInputs;
			this.loadRemoteData();

		}

	}


	/**
	* I load the primary payload for the current view.
	*/
	private async loadRemoteData() : Promise<void> {

		try {

			this.isLoading = true;
			await this.loadRemoteDataInBackground();

		} catch ( error ) {

			if ( this.errorService.handleError( error ) ) {

				return;

			}

			console.group( "Remote Data Load Error" );
			console.error( error );
			console.groupEnd();

			switch ( this.errorService.getType( error ) ) {
				case "App.NotFound":

					this.router.navigate(
						[ "/staging/environments" ],
						{
							replaceUrl: true
						}
					);

				break;
			}

		}

	}


	/**
	* I quietly load the primary payload for the current view in the background.
	*/
	private async loadRemoteDataInBackground() : Promise<void> {

		var responseID = ++LAST_RESPONSE_ID;
		var response = await this.apiClient.get<Partial>({
			url: "/index.cfm?event=api.partials.ngInternal.staging.user",
			params: {
				userID: this.routeInputs.userID
			}
		});

		if ( responseID !== LAST_RESPONSE_ID ) {

			throw new ExpiredResponseError( "StagingUser" );

		}

		this.isLoading = false;
		this.user = response.user;
		this.environments = response.environments;
		this.features = response.features;
		this.breakdown = response.breakdown;

		this.setWindowTitle();

	}


	/**
	* I set the window title based on the current view-model.
	*/
	private setWindowTitle() {

		if ( ! this.user ) {

			return;

		}

		this.windowTitle.set( this.user.name );

	}

}
