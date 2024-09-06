<cfscript>

	param name="request.event[ 3 ]" type="string" default="list";

	switch ( request.event[ 3 ] ) {
		case "list":
			cfmodule( template = "./list.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Playground.Users.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

</cfscript>