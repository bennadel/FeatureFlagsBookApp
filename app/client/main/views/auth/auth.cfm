<cfscript>

	param name="request.event[ 2 ]" type="string" default="login";

	switch ( request.event[ 2 ] ) {
		case "login":
			cfmodule( template = "./login/login.cfm" );
		break;
		case "logout":
			cfmodule( template = "./logout/logout.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Auth.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

	cfmodule( template = "./common/layout.cfm" );

</cfscript>
