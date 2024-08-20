<cfscript>

	demoUsers = request.ioc.get( "lib.demo.DemoUsers" );

	request.template.primaryContent = {
		// Base 100 users.
		users: demoUsers.getUsers( request.user.email ),
		// Additional users based on logged-in user.
		authenticatedUsers: demoUsers.buildAuthenticatedUsers( request.user.email )
	};

</cfscript>
