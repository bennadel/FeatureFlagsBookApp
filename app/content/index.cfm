<cfscript>

	config = request.ioc.get( "config" );
	errorService = request.ioc.get( "lib.ErrorService" );
	logger = request.ioc.get( "lib.Logger" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	request.template = {
		type: "internal",
		statusCode: 200,
		statusText: "OK"
	};

	try {

		param name="request.event[ 1 ]" type="string" default="home";

		switch ( request.event[ 1 ] ) {
			case "auth":
				cfmodule( template = "./views/auth/index.cfm" );
			break;
			case "home":
				cfmodule( template = "./views/home/index.cfm" );
			break;
			case "staging":
				cfmodule( template = "./views/staging/index.cfm" );
			break;
			default:
				throw(
					type = "App.Routing.InvalidEvent",
					message = "Unknown routing event."
				);
			break;
		}

		// Now that we have executed the page, let's include the appropriate rendering
		// template.
		switch ( request.template.type ) {
			case "auth":
				cfmodule( template = "./layouts/auth.cfm" );
			break;
			case "internal":
				cfmodule( template = "./layouts/internal.cfm" );
			break;
		}

	// NOTE: Since this try/catch is happening in the index file, we know that the
	// application has, at the very least, successfully bootstrapped and that we have
	// access to all of the application-scoped services.
	} catch ( any error ) {

		logger.logException( error );
		errorResponse = errorService.getResponse( error );

		request.template.type = "error";
		request.template.statusCode = errorResponse.statusCode;
		request.template.statusText = errorResponse.statusText;
		request.template.title = errorResponse.title;
		request.template.message = errorResponse.message;
		// Used to render the error in local development debugging.
		request.lastProcessedError = error;

		cfmodule( template = "./layouts/error.cfm" );

	}

</cfscript>
