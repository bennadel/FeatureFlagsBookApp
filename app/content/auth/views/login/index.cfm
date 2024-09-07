<cfscript>

	param name="request.event[ 3 ]" type="string" default="form";

	switch ( request.event[ 3 ] ) {
		case "form":
			cfmodule( template = "./form.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Auth.Login.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

</cfscript>
