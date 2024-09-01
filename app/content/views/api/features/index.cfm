<cfscript>

	param name="request.event[ 3 ]" type="string" default="";

	switch ( request.event[ 3 ] ) {
		case "clear":
			cfmodule( template = "./clear.cfm" );
		break;
		case "reset":
			cfmodule( template = "./reset.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Api.Features.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

</cfscript>
