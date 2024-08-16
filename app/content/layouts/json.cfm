<cfscript>

	param name="request.template.statusCode" type="numeric" default=200;
	param name="request.template.statusText" type="string" default="OK";
	param name="request.template.primaryContent" type="any" default=true;

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
		variable = charsetDecode( serializeJson( request.template.primaryContent ), "utf-8" )
	);

</cfscript>
