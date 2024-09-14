<cfoutput>

	<!doctype html>
	<html lang="en">
	<head>
		<cfmodule template="/content/common/meta.cfm">
		<cfmodule template="/content/common/title.cfm">
		<cfmodule template="/content/common/favicon.cfm">
		<cfmodule template="/content/common/bugsnag.cfm">
		<cfmodule template="/content/common/css.cfm">

		<!--- Todo: Replace with Parcel-generated files. --->
	</head>
	<body>

		#request.template.primaryContent#

		<cfmodule template="/content/common/local_debugging.cfm">

	</body>
	</html>

</cfoutput>
