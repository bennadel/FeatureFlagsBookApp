
// Common errors for the application.

/**
* I represent an expired HTTP response.
*/
export class ExpiredResponseError extends Error {

	public context: string;

	/**
	* I initialize the error.
	*/
	constructor( context: string = "Unknown" ) {

		super( "Expired response." );
		this.context = context;

	}

}
