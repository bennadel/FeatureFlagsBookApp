<cfscript>

	param name="request.event[ 5 ]" type="string" default="";

	switch ( request.event[ 5 ] ) {
		case "list":
			cfmodule( template = "./list.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Api.Partials.NgInternal.Features.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

</cfscript>