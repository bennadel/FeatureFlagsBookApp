<cfscript>

	demoUsers = request.ioc.get( "lib.demo.DemoUsers" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	request.template.title = "Demo Users For Targeting";

	include "./users.view.cfm";

</cfscript>
