<cfscript>

	requestMetadata = request.ioc.get( "core.lib.RequestMetadata" );
	ui = request.ioc.get( "client.main.lib.ViewHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.template.statusCode" type="numeric" default=200;
	param name="request.template.statusText" type="string" default="OK";
	param name="request.template.title" type="string" default="";
	param name="request.template.activeNavItem" type="string" default="";
	param name="request.template.primaryContent" type="string" default="";
	param name="request.template.video" type="string" default="";

	internalUrl = requestMetadata.getInternalUrl();

	// Override the response status code.
	cfheader(
		statusCode = request.template.statusCode,
		statusText = request.template.statusText
	);
	// Reset the output buffer.
	cfcontent( type = "text/html; charset=utf-8" );

	include "./layout.view.cfm";

</cfscript>
