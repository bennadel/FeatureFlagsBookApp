<cfscript>

	requestHelper = request.ioc.get( "lib.RequestHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	// SECURITY: This SPA experience requires an authenticated user.
	request.user = requestHelper.ensureAuthenticatedUser();

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

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
