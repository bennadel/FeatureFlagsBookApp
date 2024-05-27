<cfscript>

	// Every page in the auth subsystem will use the auth template. This is exclusively a
	// non-logged-in part of the application and will have a simplified UI.
	request.template.type = "auth";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.event[ 2 ]" type="string" default="login";

	switch ( request.event[ 2 ] ) {
		case "login":
			cfmodule( template = "./login.cfm" );
		break;
		case "logout":
			cfmodule( template = "./logout.cfm" );
		break;
		case "logoutSuccess":
			cfmodule( template = "./logoutSuccess.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Auth.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

</cfscript>
