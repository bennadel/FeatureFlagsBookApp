<cfscript>

	demoUsers = request.ioc.get( "lib.demo.DemoUsers" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	request.template.title = "Demo Users For Targeting";

	include "./list.view.cfm";

</cfscript>
