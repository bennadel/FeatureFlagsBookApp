<cfscript>

	param name="request.event[ 4 ]" type="string" default="targeting";

	switch ( request.event[ 4 ] ) {
		case "clear":
			cfmodule( template = "./clear/clear.cfm" );
		break;
		case "defaultResolution":
			cfmodule( template = "./defaultResolution/defaultResolution.cfm" );
		break;
		case "delete":
			cfmodule( template = "./delete/delete.cfm" );
		break;
		case "deleteRule":
			cfmodule( template = "./deleteRule/deleteRule.cfm" );
		break;
		case "rule":
			cfmodule( template = "./rule/rule.cfm" );
		break;
		case "rulesEnabled":
			cfmodule( template = "./rulesEnabled/rulesEnabled.cfm" );
		break;
		case "targeting":
			cfmodule( template = "./targeting/targeting.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Playground.Features.Detail.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

</cfscript>
