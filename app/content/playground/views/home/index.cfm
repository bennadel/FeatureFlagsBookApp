<cfscript>

	param name="request.event[ 3 ]" type="string" default="welcome";

	switch ( request.event[ 3 ] ) {
		case "welcome":
			cfmodule( template = "./welcome.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Playground.Home.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

</cfscript>
