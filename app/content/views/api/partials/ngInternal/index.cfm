<cfscript>

	param name="request.event[ 4 ]" type="string" default="";

	switch ( request.event[ 4 ] ) {
		case "users":
			cfmodule( template = "./users.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Api.Partials.NgInternal.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

</cfscript>
