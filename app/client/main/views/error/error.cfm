<cfscript>

	errorService = request.ioc.get( "core.lib.ErrorService" );
	logger = request.ioc.get( "core.lib.Logger" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="attributes.error" type="any";

	logger.logException( attributes.error );
	errorResponse = errorService.getResponse( attributes.error );
	title = errorResponse.title;
	message = errorResponse.message;

	request.template.title = title;
	// Used to render the error in local development debugging.
	request.lastProcessedError = attributes.error;

	// Override the response status code.
	cfheader(
		statusCode = errorResponse.statusCode,
		statusText = errorResponse.statusText
	);
	// Reset the output buffer.
	cfcontent( type = "text/html; charset=utf-8" );

	include "./error.view.cfm";

</cfscript>
