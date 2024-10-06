<cfscript>

	param name="request.event[ 3 ]" type="string" default="json";

	request.template.activeNavItem = "raw";

	switch ( request.event[ 3 ] ) {
		case "json":
			cfmodule( template = "./json/json.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Playground.Raw.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

</cfscript>
