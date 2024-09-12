<cfscript>

	param name="request.event[ 3 ]" type="string" default="";

	request.template.activeNavItem = "staging";

	switch ( request.event[ 3 ] ) {
		case "explain":
			cfmodule( template = "./explain.cfm" );
		break;
		case "matrix":
			cfmodule( template = "./matrix.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Playground.Staging.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

</cfscript>
