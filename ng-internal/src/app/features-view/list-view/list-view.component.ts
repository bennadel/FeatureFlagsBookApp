
// Import vendor modules.
import { ActivatedRoute } from "@angular/router";
import { Component } from "@angular/core";
import { DestroyRef } from "@angular/core";
import { inject } from "@angular/core";
import { RouterLink } from "@angular/router";
import { SimpleChanges } from "@angular/core";

// Import app modules.
import { ApiClient } from "~/app/shared/services/api-client";
import { Demo } from "~/app/shared/types";
import { ErrorService } from "~/app/shared/services/error.service";
import { ExpiredResponseError } from "~/app/shared/services/error.service";
import { SpinnerComponent } from "~/app/shared/components/spinner/spinner.component";
import { WindowTitle } from "~/app/shared/services/window-title";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

interface Partial {
	features: Demo.Feature[];
	environments: Demo.Environment[];
	breakdowns: Breakdowns;
};

interface Breakdowns {
	[ featureKey: string ]: {
		[ environmentKey: string ]: {
			variantIndex: number;
			count: number;
		}[];
	};
};

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

var CACHED_RESPONSE: Partial | null = null;
var LAST_RESPONSE_ID = 0;

@Component({
	selector: "features-list-view",
	standalone: true,
	imports: [
		RouterLink,
		SpinnerComponent
	],
	styleUrl: "./list-view.component.less",
	templateUrl: "./list-view.component.html"
})
export class ListViewComponent {

	private activatedRoute = inject( ActivatedRoute );
	private apiClient = inject( ApiClient );
	private destroyRef = inject( DestroyRef );
	private errorService = inject( ErrorService );
	private windowTitle = inject( WindowTitle );

	public isLoading = true;
	public features: Demo.Feature[] = [];
	public environments: Demo.Environment[] = [];
	public breakdowns: Breakdowns = {};

	// ---
	// LIFE-CYCLE METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "Feature Flags Playground" );
		this.loadRemoteData();

		// When the component is destroyed, we want to change the last response ID so that
		// any pending data load will be ignored.
		this.destroyRef.onDestroy( () => LAST_RESPONSE_ID++ );

	}

	// ---
	// PRIVATE METHODS.
	// ---

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

		if ( useCache && CACHED_RESPONSE ) {

			this.isLoading = false;
			this.features = CACHED_RESPONSE.features;
			this.environments = CACHED_RESPONSE.environments;
			this.breakdowns = CACHED_RESPONSE.breakdowns;

		}

		var responseID = ++LAST_RESPONSE_ID;
		var response = await this.apiClient.get<Partial>({
			url: "/index.cfm?event=api.partials.ngInternal.features.list"
		});

		if ( responseID !== LAST_RESPONSE_ID ) {

			throw new ExpiredResponseError( "FeatureFlagsList" );

		}

		CACHED_RESPONSE = response;

		console.group( "Load Remote Data" );
		console.log( response );
		console.groupEnd();

		this.isLoading = false;
		this.features = CACHED_RESPONSE.features;
		this.environments = CACHED_RESPONSE.environments;
		this.breakdowns = CACHED_RESPONSE.breakdowns;

	}

}
