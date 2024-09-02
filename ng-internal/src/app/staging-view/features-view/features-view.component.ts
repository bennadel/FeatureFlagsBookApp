
// Import vendor modules.
import { ActivatedRoute } from "@angular/router";
import { Component } from "@angular/core";
import { DestroyRef } from "@angular/core";
import { inject } from "@angular/core";
import { Router } from "@angular/router";
import { RouterLink } from "@angular/router";
import { RouterLinkActive } from "@angular/router";

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
	environmentKey: string;
};

interface Partial {
	environments: Demo.Environment[];
	features: Demo.Feature[];
	users: Demo.User[];
	breakdown: Breakdown;
};

interface Breakdown {
	[ environmentKey: string ]: {
		[ userID: string ]: {
			[ featureKey: string ]: {
				variantIndex: number;
				variant: string; // Serialized on the server.
			}
		};
	};
};

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

var CACHED_RESPONSE: Partial | null = null;
var LAST_RESPONSE_ID = 0;

@Component({
	selector: "staging-features-view",
	standalone: true,
	imports: [
		RouterLink,
		RouterLinkActive,
		SpinnerComponent
	],
	styleUrl: "./features-view.component.less",
	templateUrl: "./features-view.component.html"
})
export class FeaturesViewComponent {

	private activatedRoute = inject( ActivatedRoute );
	private apiClient = inject( ApiClient );
	private destroyRef = inject( DestroyRef );
	private errorService = inject( ErrorService );
	private router = inject( Router );
	private windowTitle = inject( WindowTitle );

	public routeInputs: RouteInputs = {
		environmentKey: ""
	};
	public isLoading = true;
	public users: Demo.User[] = [];
	public features: Demo.Feature[] = [];
	public environments: Demo.Environment[] = [];
	public breakdown: Breakdown = {};
	public environmentKey = "";

	// ---
	// LIFE-CYCLE METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "Features" );

		this.activatedRoute.params.subscribe( this.handleActivatedRouteChange );
		this.loadRemoteData();

		// When the component is destroyed, we want to change the last response ID so that
		// any pending data load will be ignored.
		this.destroyRef.onDestroy( () => LAST_RESPONSE_ID++ );

	}

	// ---
	// PUBLIC METHODS.
	// ---

	public scrollToEvaluation( userID: number, featureKey: string ) {

		var target = document
			.querySelector(
				`.variant` +
				`[ data-user-id = "${ userID }" ]` +
				`[ data-feature-key = "${ featureKey }" ]`
			)
		;

		target?.scrollIntoView({
			behavior: "smooth",
			block: "center",
			inline: "center"
		})

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
			environmentKey: ( snapshot.params.environmentKey || "" )
		};

	}


	/**
	* I handle changes to the activated route, updating the view-model as necessary.
	*/
	private handleActivatedRouteChange = () => {

		this.routeInputs = this.getRouteInputs();

		if ( ! this.isLoading ) {

			this.loadLocalData();

			// ... set some stuff ....
			// ... scroll some things ....

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

			if ( ! this.errorService.handleError( error ) ) {

				console.group( "Remote Data Load Error" );
				console.error( error );
				console.groupEnd();

			}

		}

	}


	private loadLocalData() {

		if ( ! this.breakdown.hasOwnProperty( this.routeInputs.environmentKey ) ) {

			this.router.navigate(
				[ "/staging/features", this.environments[ 0 ].key ],
				{
					replaceUrl: true
				}
			);
			return;

		}

		this.environmentKey = this.routeInputs.environmentKey;

	}


	/**
	* I quietly load the primary payload for the current view in the background.
	*/
	private async loadRemoteDataInBackground( useCache = true ) : Promise<void> {

		if ( useCache && CACHED_RESPONSE ) {

			this.isLoading = false;
			this.environments = CACHED_RESPONSE.environments;
			this.features = CACHED_RESPONSE.features;
			this.users = CACHED_RESPONSE.users;
			this.breakdown = CACHED_RESPONSE.breakdown;

			this.loadLocalData();

		}

		var responseID = ++LAST_RESPONSE_ID;
		var response = await this.apiClient.get<Partial>({
			url: "/index.cfm?event=api.partials.ngInternal.staging.features"
		});

		if ( responseID !== LAST_RESPONSE_ID ) {

			throw new ExpiredResponseError( "StagingFeatures" );

		}

		CACHED_RESPONSE = response;

		this.isLoading = false;
		this.environments = CACHED_RESPONSE.environments;
		this.features = CACHED_RESPONSE.features;
		this.users = CACHED_RESPONSE.users;
		this.breakdown = CACHED_RESPONSE.breakdown;

		this.loadLocalData();

	}

}
