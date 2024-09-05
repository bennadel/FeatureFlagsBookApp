
// Import vendor modules.
import { ActivatedRoute } from "@angular/router";
import { Component } from "@angular/core";
import { FormsModule } from "@angular/forms";
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
	featureKey: string;
};

interface Partial {
	feature: Demo.Feature;
};

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

var LAST_RESPONSE_ID = 0;

@Component({
	selector: "detail-delete-view",
	standalone: true,
	imports: [
		FormsModule,
		JsonPipe,
		RouterLink,
		SpinnerComponent
	],
	styleUrl: "./delete-view.component.less",
	templateUrl: "./delete-view.component.html"
})
export class DeleteViewComponent {

	private activatedRoute = inject( ActivatedRoute );
	private apiClient = inject( ApiClient );
	private errorService = inject( ErrorService );
	private router = inject( Router );
	private windowTitle = inject( WindowTitle );

	public routeInputs: RouteInputs = {
		featureKey: ""
	};
	public isLoading = true;
	public feature: Demo.Feature | null = null;
	public errorMessage = "";

	// ---
	// LIFE-CYCLE METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "Delete Feature Flag" );
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
	// PUBLIC METHODS.
	// ---

	/**
	* I process the form submission.
	*/
	public async processForm() {

		// Pedantic: Here to satisfy the TypeScript null possibility.
		if ( ! this.feature ) {

			return;

		}

		try {

			await this.apiClient.post({
				url: "/index.cfm?event=api.features.delete",
				data: {
					featureKey: this.feature.key
				}
			});

			this.router.navigateByUrl( "/features" );

		} catch ( error ) {

			if ( this.errorService.handleError( error ) ) {

				return;

			}

			this.errorMessage = this.errorService.getMessage( error );

		}

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
			featureKey: ( snapshot.params.featureKey || "" )
		};

	}


	/**
	* I handle changes to the activated route, updating the view-model as necessary.
	*/
	private handleActivatedRouteChange = () => {

		var currentInputs = this.getRouteInputs();

		if ( currentInputs.featureKey !== this.routeInputs.featureKey ) {

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

			console.group( "Load Remote Data Error" );
			console.error( error );
			console.groupEnd();

		}

	}


	/**
	* I quietly load the primary payload for the current view in the background.
	*/
	private async loadRemoteDataInBackground() : Promise<void> {

		var responseID = ++LAST_RESPONSE_ID;
		var response = await this.apiClient.get<Partial>({
			url: "/index.cfm?event=api.partials.ngInternal.features.detail.delete",
			params: {
				featureKey: this.routeInputs.featureKey
			}
		});

		if ( responseID !== LAST_RESPONSE_ID ) {

			throw new ExpiredResponseError( "DeleteFeatureFlag" );

		}

		this.isLoading = false;
		this.feature = response.feature;

	}

}
