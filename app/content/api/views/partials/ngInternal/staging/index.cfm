<cfscript>

	param name="request.event[ 5 ]" type="string" default="";

	switch ( request.event[ 5 ] ) {
		case "environments":
			cfmodule( template = "./environments.cfm" );
		break;
		case "explain":
			cfmodule( template = "./explain.cfm" );
		break;
		case "features":
			cfmodule( template = "./features.cfm" );
		break;
		case "user":
			cfmodule( template = "./user.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Api.Partials.NgInternal.Staging.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

</cfscript>