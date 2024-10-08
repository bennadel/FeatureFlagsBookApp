<cfscript>

	xsrfService = request.ioc.get( "core.lib.XsrfService" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	challengeName = xsrfService.getTokenNames().challenge;

	include "./xsrf.view.cfm";

</cfscript>
