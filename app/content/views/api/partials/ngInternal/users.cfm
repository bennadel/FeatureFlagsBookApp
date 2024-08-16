<cfscript>

	demoUsers = request.ioc.get( "lib.demo.DemoUsers" );

	request.template.primaryContent = {
		users: demoUsers.getUsers( request.user.email )
	};

</cfscript>
