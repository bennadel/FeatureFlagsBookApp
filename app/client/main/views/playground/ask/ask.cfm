<cfscript>

	param name="request.event[ 3 ]" type="string" default="chapters";

	request.template.activeNavItem = "ask";

	switch ( request.event[ 3 ] ) {
		case "chapters":
			cfmodule( template = "./chapters/chapters.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Playground.Ask.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

</cfscript>
