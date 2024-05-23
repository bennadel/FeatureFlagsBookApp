component
	output = false
	hint = "I provide utility methods to aide in making CFHttp requests."
	{

	/**
	* I return the embedded fileContent property as a string. This is particularly helpful
	* when a CFHttp is configured to return binary but there is an underlying network
	* failure (the network failure won't be returned as binary).
	*/
	public string function getFileContentAsString( required struct httpResponse ) {

		if ( isBinary( httpResponse.fileContent ) ) {

			return charsetEncode( httpResponse.fileContent, "utf-8" );

		}

		return httpResponse.fileContent;

	}


	/**
	* I try to parse the given fileContent as a JSON string. If the string cannot be
	* parsed, an error containing the fileContent is thrown.
	*/
	public any function parseFileContentAsJson( required string fileContent ) {

		try {

			return deserializeJson( fileContent );

		} catch ( any error ) {

			throw(
				type = "HttpUtilities.JsonParse",
				message = "File content could not be parsed as JSON.",
				extendedInfo = "File content: #fileContent#"
			);

		}

	}


	/**
	* I parse the status code field into a structured response.
	*/
	public struct function parseStatusCode( required struct httpResponse ) {

		return {
			code: listFirst( httpResponse.statusCode, " " ),
			text: listRest( httpResponse.statusCode, " " ),
			family: "#httpResponse.statusCode[ 1 ]#xx",
			ok: ( httpResponse.statusCode[ 1 ] == "2" ),
			original: httpResponse.statusCode
		};

	}


	/**
	* I determine if the given response has a failure status code.
	*/
	public boolean function statusCodeIsFailure( required struct httpResponse ) {

		return ! statusCodeIsOk( httpResponse );

	}


	/**
	* I determine if the given response has a success status code.
	*/
	public boolean function statusCodeIsOk( required struct httpResponse ) {

		return httpResponse.statusCode
			.reFind( "2\d\d" )
		;

	}

}
