<cfscript>

	param name="request.event[ 3 ]" type="string" default="list";

	request.template.activeNavItem = "features";

	switch ( request.event[ 3 ] ) {
		case "clear":
			cfmodule( template = "./clear/clear.cfm" );
		break;
		case "create":
			cfmodule( template = "./create/create.cfm" );
		break;
		case "detail":
			cfmodule( template = "./detail/detail.cfm" );
		break;
		case "list":
			cfmodule( template = "./list/list.cfm" );
		break;
		case "reset":
			cfmodule( template = "./reset/reset.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Playground.Features.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

</cfscript>
