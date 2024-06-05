component
	output = false
	hint = "I implement the StartsWith operator."
	{

	/**
	* I test to see if the given context value starts with one of the given values.
	*/
	public boolean function test(
		required any contextValue,
		required array values
		) {

		for ( var value in values ) {

			var prefixLength = len( value );
			var prefix = left( contextValue, prefixLength );

			if ( value == prefix ) {

				return true;

			}

		}

		return false;

	}

}
