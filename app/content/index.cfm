<cfscript>

	errorService = request.ioc.get( "lib.ErrorService" );
	logger = request.ioc.get( "lib.Logger" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	try {

		param name="request.event[ 1 ]" type="string" default="playground";

		switch ( request.event[ 1 ] ) {
			case "api":
				cfmodule( template = "./api/index.cfm" );
			break;
			case "auth":
				cfmodule( template = "./auth/auth.cfm" );
			break;
			case "playground":
				cfmodule( template = "./playground/playground.cfm" );
			break;
			default:
				throw(
					type = "App.Routing.InvalidEvent",
					message = "Unknown routing event."
				);
			break;
		}

	// NOTE: Since this try/catch is happening in the index file, we know that the
	// application has, at the very least, successfully bootstrapped and that we have
	// access to all of the application-scoped services.
	} catch ( any error ) {

		cfmodule(
			template = "./error/error.cfm",
			error = error
		);

	}

</cfscript>
