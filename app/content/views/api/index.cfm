<cfscript>

	errorService = request.ioc.get( "lib.ErrorService" );
	logger = request.ioc.get( "lib.Logger" );
	requestHelper = request.ioc.get( "lib.RequestHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	// Every page in the API subsystem will use the json template - even the errors.
	request.template.type = "json";

	// This subsystem has its own error handling so that errors can be captured locally
	// and delivered as JSON.
	try {

		// SECURITY: This entire subsystem requires an authenticated user.
		request.user = requestHelper.getAuthenticatedUser();

		// --------------------------------------------------------------------------- //
		// --------------------------------------------------------------------------- //

		param name="request.event[ 2 ]" type="string" default="";

		switch ( request.event[ 2 ] ) {
			case "partials":
				cfmodule( template = "./partials/index.cfm" );
			break;
			default:
				throw(
					type = "App.Routing.Api.InvalidEvent",
					message = "Unknown routing event."
				);
			break;
		}

	} catch ( any error ) {

		logger.logException( error );
		errorResponse = errorService.getResponse( error );

		request.template.statusCode = errorResponse.statusCode;
		request.template.statusText = errorResponse.statusText;
		request.template.primaryContent = {
			error: {
				type: errorResponse.type,
				message: errorResponse.message
			}
		};

	}

</cfscript>
