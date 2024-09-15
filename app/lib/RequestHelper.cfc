component
	output = false
	hint = "I provide utility methods to make processing request data easier (or, at least, less repetitive)."
	{

	// Define properties for dependency-injection.
	property name="authWorkflow" ioc:type="lib.workflow.AuthWorkflow";
	property name="errorService" ioc:type="lib.ErrorService";
	property name="logger" ioc:type="lib.Logger";
	property name="requestMetadata" ioc:type="lib.RequestMetadata";

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I assert that the current request is made as a POST.
	*/
	public void function assertHttpPost() {

		if ( requestMetadata.getMethod() != "POST" ) {

			throw(
				type = "App.MethodNotAllowed",
				message = "Request must be made using POST."
			);

		}

	}


	/**
	* I return the currently authenticated user; and, if the user isn't authenticated, I
	* redirect the request to the login.
	*/
	public struct function ensureAuthenticatedUser() {

		var maybeUser = authWorkflow.maybeGetRequestUser();

		if ( ! maybeUser.exists ) {

			redirectToLogin();

		}

		return maybeUser.value;

	}


	/**
	* I return the currently authenticated user; and, if the user isn't authenticated, I
	* throw an unauthenticated error.
	*/
	public struct function getAuthenticatedUser() {

		var maybeUser = authWorkflow.maybeGetRequestUser();

		if ( ! maybeUser.exists ) {

			throw(
				type = "App.Unauthorized",
				message = "Unauthenticated user accessed secure area."
			);

		}

		return maybeUser.value;

	}


	/**
	* I forward the user an internal URL constructed with the given parts.
	*/
	public void function goto(
		any searchParams = [:],
		string fragment = ""
		) {

		if ( isSimpleValue( searchParams ) ) {

			gotoV2( { event: searchParams }, fragment );

		} else {

			gotoV2( searchParams, fragment );
		}

	}


	/**
	* I forward the user an internal URL constructed with the given parts.
	*/
	public void function gotoV2(
		required struct searchParams,
		required string fragment
		) {

		var nextUrl = "/index.cfm";

		if ( searchParams.count() ) {

			var pairs = searchParams.keyArray()
				.map(
					( key ) => {

						return "#encodeForUrl( key )#=#encodeForUrl( searchParams[ key ] )#";

					}
				)
				.toList( "&" )
			;

			nextUrl &= "?#pairs#";

		}

		if ( fragment.len() ) {

			nextUrl &= "###encodeForUrl( fragment )#";

		}

		location(
			url = nextUrl,
			addToken = false
		);

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


	/**
	* I redirect to the given target URL (if it's internal); or, use the fallback URL.
	*/
	public void function redirect(
		required string targetUrl,
		required string fallbackUrl
		) {

		var nextUrl = requestMetadata.isInternalUrl( targetUrl )
			? targetUrl
			: fallbackUrl
		;

		location(
			url = nextUrl,
			addToken = false
		);

	}


	/**
	* I redirect the user to the login / authentication subsystem.
	*/
	public void function redirectToLogin() {

		var redirectTo = requestMetadata.getInternalUrl();

		location(
			url = "/index.cfm?event=auth&redirectTo=#encodeForUrl( redirectTo )#",
			addToken = false
		);

	}

}
