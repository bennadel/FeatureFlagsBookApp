<cfoutput>

	<!doctype html>
	<html lang="en">
	<head>
		<cfmodule template="/client/main/views/common/tags/meta.cfm">
		<cfmodule template="/client/main/views/common/tags/title.cfm">
		<cfmodule template="/client/main/views/common/tags/favicon.cfm">
		<cfmodule template="/client/main/views/common/tags/bugsnag.cfm">

		<!--- HTML files dynamically generated by Parcel. --->
		<cfinclude template="/wwwroot/client/main/main.html" />
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

		<cfmodule template="/client/main/views/common/tags/localDebugging.cfm">

	</body>
	</html>

</cfoutput>
