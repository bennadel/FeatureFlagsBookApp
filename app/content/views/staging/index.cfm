<cfscript>

	requestHelper = request.ioc.get( "lib.RequestHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	// SECURITY: This entire subsystem requires an authenticated user.
	request.user = requestHelper.ensureAuthenticatedUser();

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.event[ 2 ]" type="string" default="overview";

	switch ( request.event[ 2 ] ) {
		case "overview":
			cfmodule( template = "./overview.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Staging.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

</cfscript>
