<cfscript>

	param name="request.event[ 2 ]" type="string" default="login";

	request.template = {
		statusCode: 200,
		statusText: "OK"
	};

	switch ( request.event[ 2 ] ) {
		case "login":
			cfmodule( template = "./views/login/login.cfm" );
		break;
		case "logout":
			cfmodule( template = "./views/logout/logout.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Auth.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

	cfmodule( template = "./layouts/default.cfm" );

</cfscript>
