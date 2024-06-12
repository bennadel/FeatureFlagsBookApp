<cfscript>

	requestHelper = request.ioc.get( "lib.RequestHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	// SECURITY: This entire subsystem requires an authenticated user.
	request.user = requestHelper.ensureAuthenticatedUser();

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.event[ 2 ]" type="string" default="";

	switch ( request.event[ 2 ] ) {
		case "raw":
			cfmodule( template = "./raw.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Features.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

</cfscript>
