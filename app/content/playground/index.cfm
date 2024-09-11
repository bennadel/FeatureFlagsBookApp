<cfscript>

	requestHelper = request.ioc.get( "lib.RequestHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	// SECURITY: This entire subsystem requires an authenticated user.
	request.user = requestHelper.ensureAuthenticatedUser();

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.event[ 2 ]" type="string" default="home";

	request.template = {
		statusCode: 200,
		statusText: "OK"
	};

	switch ( request.event[ 2 ] ) {
		// case "features":
		// case "staging":
		// case "about":
		// case "raw":
		// case "account":
		case "account":
			cfmodule( template = "./views/account/index.cfm" );
		break;
		case "features":
			cfmodule( template = "./views/features/index.cfm" );
		break;
		case "home":
			cfmodule( template = "./views/home/index.cfm" );
		break;
		case "staging":
			cfmodule( template = "./views/staging/index.cfm" );
		break;
		case "users":
			cfmodule( template = "./views/users/index.cfm" );
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
