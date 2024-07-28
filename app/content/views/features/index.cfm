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
		case "defaultResolution":
			cfmodule( template = "./defaultResolution.cfm" );
		break;
		case "deleteRule":
			cfmodule( template = "./deleteRule.cfm" );
		break;
		case "raw":
			cfmodule( template = "./raw.cfm" );
		break;
		case "reset":
			cfmodule( template = "./reset.cfm" );
		break;
		case "rule":
			cfmodule( template = "./rule.cfm" );
		break;
		case "rulesEnabled":
			cfmodule( template = "./rulesEnabled.cfm" );
		break;
		case "targeting":
			cfmodule( template = "./targeting.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Features.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

</cfscript>
