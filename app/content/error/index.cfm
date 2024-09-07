<cfscript>

	errorService = request.ioc.get( "lib.ErrorService" );
	logger = request.ioc.get( "lib.Logger" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="attributes.error" type="any";

	logger.logException( attributes.error );
	errorResponse = errorService.getResponse( attributes.error );

	request.template = {
		statusCode: errorResponse.statusCode,
		statusText: errorResponse.statusText,
		title: errorResponse.title,
		message: errorResponse.message
	};
	// Used to render the error in local development debugging.
	request.lastProcessedError = attributes.error;

	// Override the response status code.
	cfheader(
		statusCode = request.template.statusCode,
		statusText = request.template.statusText
	);
	// Reset the output buffer.
	cfcontent( type = "text/html; charset=utf-8" );

</cfscript>
<!--- Todo: move this to a template somewhere??? --->
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
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			#encodeForHtml( request.template.message )#
		</p>

		<hr />

		<p>
			In the meantime, you can <a href="/index.cfm">return to the homepage</a>.
		</p>

		<cfmodule template="/content/common/local_debugging.cfm">

	</body>
	</html>

</cfoutput>