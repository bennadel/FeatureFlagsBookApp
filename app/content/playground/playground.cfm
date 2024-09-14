<cfscript>

	requestHelper = request.ioc.get( "lib.RequestHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	// SECURITY: This entire subsystem requires an authenticated user.
	request.user = requestHelper.ensureAuthenticatedUser();

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.event[ 2 ]" type="string" default="features";

	request.template = {
		statusCode: 200,
		statusText: "OK"
	};

	switch ( request.event[ 2 ] ) {
		case "account":
			cfmodule( template = "./views/account/account.cfm" );
		break;
		case "features":
			cfmodule( template = "./views/features/features.cfm" );
		break;
		case "staging":
			cfmodule( template = "./views/staging/staging.cfm" );
		break;
		case "users":
			cfmodule( template = "./views/users/users.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Playground.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

	cfmodule( template = "./layouts/default.cfm" );

</cfscript>
