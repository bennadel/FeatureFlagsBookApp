<cfscript>

	param name="request.event[ 4 ]" type="string" default="";

	switch ( request.event[ 4 ] ) {
		case "features":
			cfmodule( template = "./features/index.cfm" );
		break;
		case "staging":
			cfmodule( template = "./staging/index.cfm" );
		break;
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
