<cfscript>

	param name="request.event[ 7 ]" type="string" default="";

	switch ( request.event[ 7 ] ) {
		case "overview":
			cfmodule( template = "./overview.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Api.Partials.NgInternal.Features.Detail.Targeting.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

</cfscript>
