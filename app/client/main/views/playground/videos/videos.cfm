<cfscript>

	param name="request.event[ 3 ]" type="string" default="list";

	switch ( request.event[ 3 ] ) {
		case "list":
			cfmodule( template = "./list/list.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Playground.Videos.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

</cfscript>
