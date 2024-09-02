
// Import vendor modules.
import { Component } from "@angular/core";
import { DestroyRef } from "@angular/core";
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

interface Partial {
	environments: Demo.Environment[];
	users: Demo.User[];
};

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

var CACHED_RESPONSE: Partial | null = null;
var LAST_RESPONSE_ID = 0;

@Component({
	selector: "staging-environments-view",
	standalone: true,
	imports: [
		RouterLink,
		SpinnerComponent
	],
	styleUrl: "./environments-view.component.less",
	templateUrl: "./environments-view.component.html"
})
export class EnvironmentsViewComponent {

	private apiClient = inject( ApiClient );
	private destroyRef = inject( DestroyRef );
	private errorService = inject( ErrorService );
	private windowTitle = inject( WindowTitle );

	public isLoading = true;
	public environments: Demo.Environment[] = [];
	public users: Demo.User[] = [];

	// ---
	// LIFE-CYCLE METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "Feature Flag Staging" );
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

			console.group( "Remote Data Load Error" );
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
			this.environments = CACHED_RESPONSE.environments;
			this.users = CACHED_RESPONSE.users;

		}

		var responseID = ++LAST_RESPONSE_ID;
		var response = await this.apiClient.get<Partial>({
			url: "/index.cfm?event=api.partials.ngInternal.staging.environments"
		});

		if ( responseID !== LAST_RESPONSE_ID ) {

			throw new ExpiredResponseError( "StagingEnvironments" );

		}

		CACHED_RESPONSE = response;

		this.isLoading = false;
		this.environments = CACHED_RESPONSE.environments;
		this.users = CACHED_RESPONSE.users;

	}

}
