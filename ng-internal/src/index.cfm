<cfscript>

	requestHelper = request.ioc.get( "lib.RequestHelper" );
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
	<cfmodule template="/content/layouts/shared/meta.cfm">
	<cfmodule template="/content/layouts/shared/title.cfm">
	<cfmodule template="/content/layouts/shared/favicon.cfm">
	<cfmodule template="/content/layouts/shared/bugsnag.cfm">

	<!--- For the Angular experience. --->
	<base href="./">
	<script type="text/javascript">
		window.authenticatedUser = JSON.parse( "<cfoutput>#encodeForJavaScript( serializeJson( request.user ) )#</cfoutput>" );
	</script>
</head>
<body>

	<app-root></app-root>

</body>
</html>
