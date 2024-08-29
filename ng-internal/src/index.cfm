<cfscript>

	requestHelper = request.ioc.get( "lib.RequestHelper" );
	requestMetadata = request.ioc.get( "lib.RequestMetadata" );
	xsrfService = request.ioc.get( "lib.XsrfService" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	// Security: This SPA experience requires an authenticated user.
	request.user = requestHelper.ensureAuthenticatedUser();

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	// All API calls made in this Angular app must include the XSRF token.
	xsrfService.ensureCookie();

	request.template.title = "Feature Flags Playground";

</cfscript>

<!doctype html>
<html lang="en">
<head>
	<cfscript>
		cfmodule( template = "/content/layouts/shared/meta.cfm" );
		cfmodule( template = "/content/layouts/shared/title.cfm" );
		cfmodule( template = "/content/layouts/shared/favicon.cfm" );
		cfmodule( template = "/content/layouts/shared/bugsnag.cfm" );
	</cfscript>

	<!---
		Hack for the Angular experience: for some reason, hash-based routing strips out
		both the index file and the query-string on initial load. In order to get Angular
		to preserve the URL, we have to include the entire internal URL in the BASE HREF.
		--
		See: https://github.com/angular/angular/issues/12664#issuecomment-2317385552
	--->
	<base href="<cfoutput>#encodeForHtmlAttribute( requestMetadata.getInternalUrl() )#</cfoutput>">
	<script type="text/javascript">
		window.authenticatedUser = JSON.parse( "<cfoutput>#encodeForJavaScript( serializeJson( request.user ) )#</cfoutput>" );
	</script>
</head>
<body>

	<app-root></app-root>

</body>
</html>
