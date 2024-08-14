<cfscript>

	param name="request.template.statusCode" type="numeric" default=200;
	param name="request.template.statusText" type="string" default="OK";
	param name="request.template.primaryContent" type="any" default=true;

	// Override the response status code.
	cfheader(
		statusCode = request.template.statusCode,
		statusText = request.template.statusText
	);
	// Reset the output buffer.
	cfcontent(
		// For easier debugging (browser will render the text).
		// --
		// type = "text/plain; charset=utf-8",
		type = "application/x-json; charset=utf-8",
		variable = charsetDecode( serializeJson( request.template.primaryContent ), "utf-8" )
	);

</cfscript>
