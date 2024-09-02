
// Import vendor modules.
import { ErrorHandler } from "@angular/core";
import { inject } from "@angular/core";
import { Injectable } from "@angular/core";
import { Router } from "@angular/router";

// Import app modules.
import { ApiErrorResponse } from "~/app/shared/services/api-client";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

/**
* I represent an expired HTTP response.
*/
export class ExpiredResponseError extends Error {

	/**
	* I initialize the error.
	*/
	constructor( context: string = "Unknown" ) {

		super(
			"Expired response.",
			{
				cause: `Context: ${ context }`
			}
		);

	}

}

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Injectable({
	providedIn: "root"
})
export class ErrorService {

	private errorHandler = inject( ErrorHandler );
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
	* I attempt to extract the app error type from the given error.
	*/
	public getType( error: unknown ) : string {

		if ( error instanceof ApiErrorResponse ) {

			return error.type;

		}

		return "Unknown";

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

		// Temporary: Let's log all errors as well - this will likely be way too noisy;
		// but, for the time-being, let's see what happens and then trim-back as needed.
		this.errorHandler.handleError( error );

		switch ( this.getType( error ) ) {
			case "App.Unauthorized":

				this.router.navigateByUrl(
					"/errors/unauthorized",
					{
						skipLocationChange: true
					}
				);
				return true;

			break;
			case "App.Xsrf.Mismatch":
			case "App.Xsrf.MissingCookie":
			case "App.Xsrf.MissingHeader":

				this.router.navigateByUrl(
					"/errors/xsrf",
					{
						skipLocationChange: true
					}
				);
				return true;

			break;
			default:

				// Defer error handling to the calling context.
				return false;

			break;
		}

	}

}
