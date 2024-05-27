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

}
