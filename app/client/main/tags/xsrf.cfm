<cfscript>

	xsrfService = request.ioc.get( "client.main.lib.XsrfService" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	challengeName = xsrfService.getTokenNames().challenge;

	include "./xsrf.view.cfm";

</cfscript>
