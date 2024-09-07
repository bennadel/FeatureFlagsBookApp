<cfscript>

	param name="request.event[ 3 ]" type="string" default="form";

	switch ( request.event[ 3 ] ) {
		case "form":
			cfmodule( template = "./form.cfm" );
		break;
		case "success":
			cfmodule( template = "./success.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Auth.Logout.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

</cfscript>
