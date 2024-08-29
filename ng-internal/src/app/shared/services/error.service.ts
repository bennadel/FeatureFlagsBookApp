
// Import vendor modules.
import { inject } from "@angular/core";
import { Injectable } from "@angular/core";
import { Router } from "@angular/router";

// Import app modules.
import { ApiErrorResponse } from "~/app/shared/services/api-client";
import { ExpiredResponseError } from "~/app/shared/errors";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Injectable({
	providedIn: "root"
})
export class ErrorService {

	private router = inject( Router );

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I attempt to extract a meaningful, user-friendly message from the given error.
	*/
	public getMessage( error: unknown ) : string {

		if ( error instanceof ApiErrorResponse ) {

			return error.message;

		}

		return "An unknown error occurred.";

	}


	/**
	* I attempt to handle the error globally, returning true if handled or false if the
	* calling context should handle the error.
	*/
	public handleError( error: unknown ) : boolean {

		if ( error instanceof ExpiredResponseError ) {

			console.warn( "Ignoring expired partial response." );
			return true;

		}

		if ( error instanceof ApiErrorResponse ) {

			switch ( error.type ) {
				case "App.Unauthorized":

					this.router.navigateByUrl( "/errors/unauthorized" );
					return true;

				break;
				case "App.Xsrf.Mismatch":
				case "App.Xsrf.MissingCookie":
				case "App.Xsrf.MissingHeader":

					this.router.navigateByUrl( "/errors/xsrf" );
					return true;

				break;
			}

		}

		// Defer error handling to the calling context.
		return false;

	}

}
