<cfscript>

	param name="request.event[ 6 ]" type="string" default="";

	switch ( request.event[ 6 ] ) {
		case "targeting":
			cfmodule( template = "./targeting/index.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Api.Partials.NgInternal.Features.Detail.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

</cfscript>
