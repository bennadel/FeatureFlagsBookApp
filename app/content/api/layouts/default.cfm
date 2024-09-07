<cfscript>

	param name="request.template.statusCode" type="numeric" default=200;
	param name="request.template.statusText" type="string" default="OK";
	param name="request.template.primaryContent" type="any" default=true;
	// As an added measure of protection, we can prefix the JSON response with a commonly-
	// used string that Angular will automatically detect and remove before parsing the
	// response payload. This helps to prevent "Cross-site script inclusion (XSSI)"
	// attacks.
	// --
	// See: https://angular.dev/best-practices/security#cross-site-script-inclusion-xssi
	param name="request.template.jsonPrefix" type="any" default=")]}',#chr( 10 )#";

	// For easier debugging, you can force a text response (browser will render the
	// text/plain but will not render application/x-json; and will not make it available
	// in the network tab for some reason).
	contentType = ( url?.forceContentType == "text" )
		? "text/plain"
		: "application/x-json"
	;

	// Override the response status code.
	cfheader(
		statusCode = request.template.statusCode,
		statusText = request.template.statusText
	);
	// Reset the output buffer.
	cfcontent(
		type = "#contentType#; charset=utf-8",
		variable = charsetDecode(
			( request.template.jsonPrefix & serializeJson( request.template.primaryContent ) ),
			"utf-8"
		)
	);

</cfscript>
