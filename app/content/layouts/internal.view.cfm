<cfoutput>

	<!doctype html>
	<html lang="en">
	<head>
		<cfmodule template="./shared/meta.cfm">
		<cfmodule template="./shared/title.cfm">
		<cfmodule template="./shared/favicon.cfm">
		<cfmodule template="./shared/bugsnag.cfm">
		<cfmodule template="./shared/css.cfm">
	</head>
	<body>

		#request.template.primaryContent#

		<cfmodule template="./shared/local_debugging.cfm">
		<cfmodule template="./shared/javascript.cfm">
	</body>
	</html>

</cfoutput>
