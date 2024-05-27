component
	output = false
	hint = "I provide utility methods to make processing request data easier (or, at least, less repetitive)."
	{

	// Define properties for dependency-injection.
	property name="authWorkflow" ioc:type="lib.workflow.AuthWorkflow";
	property name="errorService" ioc:type="lib.ErrorService";
	property name="logger" ioc:type="lib.Logger";

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I return the currently authenticated user; and, if the user isn't authenticated, I
	* redirect the request to the login.
	*/
	public struct function ensureAuthenticatedUser() {

		var user = authWorkflow.getRequestUser();

		if ( ! user.exists ) {

			redirectToLogin();

		}

		return user;

	}


	/**
	* I process the given error, applying the proper status code to the template, and
	* returning the associated user-friendly response message.
	*/
	public string function processError( required any error ) {

		logger.logException( error );

		var errorResponse = errorService.getResponse( error );

		request.template.statusCode = errorResponse.statusCode;
		request.template.statusText = errorResponse.statusText;
		// Used to render the error in local development debugging.
		request.lastProcessedError = error;

		return errorResponse.message;

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I redirect the user to the login / authentication subsystem.
	*/
	private void function redirectToLogin() {

		// TODO: Include some sort of "redirectTo" parameter.
		location(
			url = "/index.cfm?event=auth",
			addToken = false
		);

	}

}
