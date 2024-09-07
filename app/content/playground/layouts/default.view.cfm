<cfoutput>

	<!doctype html>
	<html lang="en">
	<head>
		<cfmodule template="/content/common/meta.cfm">
		<cfmodule template="/content/common/title.cfm">
		<cfmodule template="/content/common/favicon.cfm">
		<cfmodule template="/content/common/bugsnag.cfm">
		<cfmodule template="/content/common/css.cfm">

		<!--- Todo: replace with Parcel-generate files. --->
	</head>
	<body>

		#request.template.primaryContent#

		<cfmodule template="/content/common/local_debugging.cfm">
		<cfmodule template="/content/common/javascript.cfm">
	</body>
	</html>

</cfoutput>
