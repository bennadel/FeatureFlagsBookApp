
// Import vendor modules.
import { ActivatedRoute } from "@angular/router";
import { Component } from "@angular/core";
import { inject } from "@angular/core";
import { JsonPipe } from "@angular/common";
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
	featureKey: string;
	environmentKey: string;
};

interface Partial {
	user: Demo.User;
	feature: Demo.Feature;
	environment: Demo.Environment;
	explanation: Demo.Explanation;
};

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

var LAST_RESPONSE_ID = 0;

@Component({
	selector: "staging-explain-view",
	standalone: true,
	imports: [
		JsonPipe,
		RouterLink,
		SpinnerComponent
	],
	styleUrl: "./explain-view.component.less",
	templateUrl: "./explain-view.component.html"
})
export class ExplainViewComponent {

	private activatedRoute = inject( ActivatedRoute );
	private apiClient = inject( ApiClient );
	private errorService = inject( ErrorService );
	private router = inject( Router );
	private windowTitle = inject( WindowTitle );

	public routeInputs: RouteInputs = {
		userID: 0,
		featureKey: "",
		environmentKey: ""
	};
	public isLoading = true;
	public user: Demo.User | null = null;
	public feature: Demo.Feature | null = null;
	public environment: Demo.Environment | null = null;
	public explanation: Demo.Explanation | null = null;

	// ---
	// LIFE-CYCLE METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "Explain" );
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
			userID: ( + snapshot.params.userID || 0 ),
			featureKey: ( snapshot.params.featureKey || "" ),
			environmentKey: ( snapshot.params.environmentKey || "" )
		};

	}


	/**
	* I handle changes to the activated route, updating the view-model as necessary.
	*/
	private handleActivatedRouteChange = () => {

		var currentInputs = this.getRouteInputs();

		if (
			( currentInputs.userID !== this.routeInputs.userID ) ||
			( currentInputs.featureKey !== this.routeInputs.featureKey ) ||
			( currentInputs.environmentKey !== this.routeInputs.environmentKey )
			) {

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
			url: "/index.cfm?event=api.partials.ngInternal.staging.explain",
			params: {
				userID: this.routeInputs.userID,
				featureKey: this.routeInputs.featureKey,
				environmentKey: this.routeInputs.environmentKey
			}
		});

		if ( responseID !== LAST_RESPONSE_ID ) {

			throw new ExpiredResponseError( "StagingExplain" );

		}

		this.isLoading = false;
		this.user = response.user;
		this.environment = response.environment;
		this.feature = response.feature;
		this.explanation = response.explanation;

		this.setWindowTitle();

	}


	/**
	* I set the window title based on the current view-model.
	*/
	private setWindowTitle() {

		if (
			! this.user ||
			! this.feature ||
			! this.environment
			) {

			return;

		}

		this.windowTitle.set( `${ this.user.name } / ${ this.feature.key } / ${ this.environment.key }` );

	}

}
