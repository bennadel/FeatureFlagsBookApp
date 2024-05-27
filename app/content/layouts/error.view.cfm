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

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			#encodeForHtml( request.template.message )#
		</p>

		<hr />

		<p>
			In the meantime, you can <a href="/index.cfm">return to the homepage</a>.
		</p>

		<cfmodule template="./shared/local_debugging.cfm">

	</body>
	</html>

</cfoutput>
