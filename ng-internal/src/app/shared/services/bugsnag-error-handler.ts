
// Import vendor modules.
import { ErrorHandler } from "@angular/core";
import { Injectable } from "@angular/core";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

// Tell TypeScript that Bugsnag is on the global namespace (window).
declare global {
	export var Bugsnag: {
		notify( error: unknown ) : void;
	};
}

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Injectable({
	providedIn: "root"
})
export class BugsnagErrorHandler implements ErrorHandler {

	/**
	* I provide an implementation of centralized logging that also sends the error to the
	* Bugsnag client.
	*/
	public handleError( error: unknown ) {

		console.group( "Bugsnag Error Handler" );
		console.error( error );
		console.groupEnd();

		window.Bugsnag?.notify( error );

	}

}
