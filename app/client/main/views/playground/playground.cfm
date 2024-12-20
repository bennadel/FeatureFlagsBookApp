<cfscript>

	requestHelper = request.ioc.get( "client.main.lib.RequestHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	// SECURITY: This entire subsystem requires an authenticated user.
	request.user = requestHelper.ensureAuthenticatedUser();

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.event[ 2 ]" type="string" default="features";

	switch ( request.event[ 2 ] ) {
		case "account":
			cfmodule( template = "./account/account.cfm" );
		break;
		case "ask":
			cfmodule( template = "./ask/ask.cfm" );
		break;
		case "features":
			cfmodule( template = "./features/features.cfm" );
		break;
		case "raw":
			cfmodule( template = "./raw/raw.cfm" );
		break;
		case "staging":
			cfmodule( template = "./staging/staging.cfm" );
		break;
		case "users":
			cfmodule( template = "./users/users.cfm" );
		break;
		case "videos":
			cfmodule( template = "./videos/videos.cfm" );
		break;
		case "walkthrough":
			cfmodule( template = "./walkthrough/walkthrough.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Playground.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

	cfmodule( template = "./common/layout.cfm" );

</cfscript>
