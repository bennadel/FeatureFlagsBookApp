component
	output = false
	hint = "I provide utility methods for model validation."
	{

	/**
	* I return the canonicalized version of the given input. Double-encoding errors are
	* suppressed and result in an empty string.
	*/
	public string function canonicalizeInput( required string input ) {

		try {

			return canonicalize( input, true, true );

		} catch ( any error ) {

			return "";

		}

	}


	/**
	* I serialize the given error for embedding within another error.
	*/
	public string function serializeRootCauseError( required any rootCause ) {

		var safeCopy = [:];

		for ( var key in [ "type", "message", "detail", "extendedInfo", "code" ] ) {

			if (
				structKeyExists( rootCause, key ) &&
				isSimpleValue( rootCause[ key ] )
				) {

				safeCopy[ key ] = toString( rootCause[ key ] );

			}

		}

		return serializeJson( safeCopy );

	}

}
