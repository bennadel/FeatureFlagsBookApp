<cfscript>

	requestHelper = request.ioc.get( "lib.RequestHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	// SECURITY: This entire subsystem requires an authenticated user.
	request.user = requestHelper.ensureAuthenticatedUser();

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.event[ 2 ]" type="string" default="welcome";

	switch ( request.event[ 2 ] ) {
		case "welcome":
			cfmodule( template = "./welcome.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Home.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

</cfscript>
