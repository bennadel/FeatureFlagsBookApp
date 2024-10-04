<cfoutput>

	<!doctype html>
	<html lang="en">
	<head>
		<cfmodule template="/content/common/meta.cfm">
		<cfmodule template="/content/common/title.cfm">
		<cfmodule template="/content/common/favicon.cfm">
		<cfmodule template="/content/common/bugsnag.cfm">

		<!--- HTML files dynamically generated by parcel. --->
		<cfinclude template="/wwwroot/client/main.html" />
	</head>
	<body>

		<main m-mlxsai class="main ui-content-wrapper">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p>
				#encodeForHtml( message )#
			</p>

			<hr class="ui-rule" />

			<p>
				In the meantime, you can <a href="/index.cfm">return to the homepage</a>.
			</p>

		</main>

		<cfmodule template="/content/common/local_debugging.cfm">

	</body>
	</html>

</cfoutput>
