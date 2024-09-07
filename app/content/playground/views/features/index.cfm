<cfscript>

	param name="request.event[ 3 ]" type="string" default="";

	switch ( request.event[ 3 ] ) {
		case "clear":
			cfmodule( template = "./clear.cfm" );
		break;
		case "create":
			cfmodule( template = "./create.cfm" );
		break;
		case "defaultResolution":
			cfmodule( template = "./defaultResolution.cfm" );
		break;
		case "delete":
			cfmodule( template = "./delete.cfm" );
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
				type = "App.Routing.Playground.Features.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

</cfscript>
