<cfscript>

	xsrfService = request.ioc.get( "client.common.lib.XsrfService" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	challengeName = xsrfService.getTokenNames().challenge;

	include "./xsrf.view.cfm";

</cfscript>
