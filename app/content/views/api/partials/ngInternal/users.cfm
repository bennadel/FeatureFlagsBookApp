<cfscript>

	demoUsers = request.ioc.get( "lib.demo.DemoUsers" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	// TODO: Move all of this logic into a Partial component.
	request.template.primaryContent = getPartial( request.user.email );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the main partial payload for the view.
	*/
	private struct function getPartial( required string email ) {

		// Base 100 users.
		var users = demoUsers.getUsers( request.user.email );
		// Additional users based on logged-in user.
		var authenticatedUsers = demoUsers.buildAuthenticatedUsers( request.user.email );

		return {
			users: users,
			authenticatedUsers: authenticatedUsers
		};

	}

</cfscript>
