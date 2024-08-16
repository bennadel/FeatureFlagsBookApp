<cfscript>

	param name="request.event[ 3 ]" type="string" default="";

	switch ( request.event[ 3 ] ) {
		case "ngInternal":
			cfmodule( template = "./ngInternal/index.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Api.Partials.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

</cfscript>
