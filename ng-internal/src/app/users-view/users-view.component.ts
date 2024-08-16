
// Import vendor modules.
import { Component } from "@angular/core";
import { inject } from "@angular/core";

// Import app modules.
import { ApiClient } from "~/app/shared/services/api-client";
import { WindowTitle } from "~/app/shared/services/window-title";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

export interface Partial {
	users: User[];
};

export interface User {
	"id": number;
	"name": string;
	"email": string;
	"role": string;
	"company": {
		"id": number;
		"subdomain": string;
		"fortune100": boolean;
		"fortune500": boolean;
	};
	"groups": {
		"betaTester": boolean;
		"influencer": boolean;
	};
};

var CACHED_RESPONSE: Partial | null = null;

@Component({
	selector: "users-view",
	standalone: true,
	imports: [],
	styleUrl: "./users-view.component.less",
	templateUrl: "./users-view.component.html"
})
export class UsersViewComponent {

	private apiClient = inject( ApiClient );
	private windowTitle = inject( WindowTitle );

	public isLoading = true;
	public users: User[] = [];

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "Demo Users" );
		this.loadRemoteData();

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I load the remote data.
	*/
	private async loadRemoteData() : Promise<void> {

		this.isLoading = true;
		this.users = [];

		if ( CACHED_RESPONSE ) {

			this.isLoading = false;
			this.users = CACHED_RESPONSE.users;

		}

		try {

			var response = CACHED_RESPONSE = await this.apiClient.get<Partial>({
				url: "/index.cfm?event=api.partials.ngInternal.users"
			});

			this.isLoading = false;
			this.users = response.users;

		} catch ( error ) {

			console.error( error );

		}

	}

}
