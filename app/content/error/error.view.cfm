<cfoutput>

	<!doctype html>
	<html lang="en">
	<head>
		<cfmodule template="/content/common/meta.cfm">
		<cfmodule template="/content/common/title.cfm">
		<cfmodule template="/content/common/favicon.cfm">
		<cfmodule template="/content/common/bugsnag.cfm">
		<cfmodule template="/content/common/css.cfm">

		<!--- Todo: replace with Parcel-generated files. --->
	</head>
	<body>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p>
			#encodeForHtml( message )#
		</p>

		<hr />

		<p>
			In the meantime, you can <a href="/index.cfm">return to the homepage</a>.
		</p>

		<cfmodule template="/content/common/local_debugging.cfm">

	</body>
	</html>

</cfoutput>
