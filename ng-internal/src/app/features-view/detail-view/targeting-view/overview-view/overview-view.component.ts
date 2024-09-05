
// Import vendor modules.
import { ActivatedRoute } from "@angular/router";
import { Component } from "@angular/core";
import { inject } from "@angular/core";
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

interface PartialCache {
	[ featureKey: string ]: Partial;
};

interface Partial {
	feature: Demo.Feature;
	environments: Demo.Environment[];
	breakdown: Breakdown;
};

interface Breakdown {
	environments: Demo.Environment[];
	users: {
		id: number;
		environments: {
			[ environmentKey: string ]: {
				ruleIndex: number;
				variantIndex: number;
			};
		};
	}[];
};

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

var CACHED_RESPONSE: PartialCache = Object.create( null );
var LAST_RESPONSE_ID = 0;

@Component({
	selector: "targeting-overview-view",
	standalone: true,
	imports: [
		RouterLink,
		SpinnerComponent
	],
	styleUrl: "./overview-view.component.less",
	templateUrl: "./overview-view.component.html"
})
export class OverviewViewComponent {

	private activatedRoute = inject( ActivatedRoute );
	private apiClient = inject( ApiClient );
	private errorService = inject( ErrorService );
	private windowTitle = inject( WindowTitle );

	public routeInputs: RouteInputs = {
		featureKey: ""
	};
	public isLoading = true;
	public feature: Demo.Feature | null = null;
	public environments: Demo.Environment[] = [];
	public breakdown: Breakdown | null = null;

	// ---
	// LIFE-CYCLE METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "Feature Flag Targeting" );
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
	private async loadRemoteDataInBackground( useCache = true ) : Promise<void> {

		if ( useCache && CACHED_RESPONSE[ this.routeInputs.featureKey ] ) {

			var response = CACHED_RESPONSE[ this.routeInputs.featureKey ];

			this.isLoading = false;
			this.feature = response.feature;
			this.environments = response.environments;
			this.breakdown = response.breakdown;

		}

		var responseID = ++LAST_RESPONSE_ID;
		var response = await this.apiClient.get<Partial>({
			url: "/index.cfm?event=api.partials.ngInternal.features.detail.targeting.overview",
			params: {
				featureKey: this.routeInputs.featureKey
			}
		});

		if ( responseID !== LAST_RESPONSE_ID ) {

			throw new ExpiredResponseError( "FeatureFlagTargeting" );

		}

		CACHED_RESPONSE[ response.feature.key ] = response;

		this.isLoading = false;
		this.feature = response.feature;
		this.environments = response.environments;
		this.breakdown = response.breakdown;

	}

}
