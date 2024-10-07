<cfscript>

	param name="request.event[ 3 ]" type="string" default="user";

	request.template.activeNavItem = "account";

	switch ( request.event[ 3 ] ) {
		case "user":
			cfmodule( template = "./user/user.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Playground.Account.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

</cfscript>
