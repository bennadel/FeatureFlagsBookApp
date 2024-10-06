component
	output = false
	hint = "I implement the EndsWith operator."
	{

	/**
	* I test to see if the given context value ends with one of the given values.
	*/
	public boolean function test(
		required any contextValue,
		required array values
		) {

		for ( var value in values ) {

			var suffixLength = len( value );
			var suffix = right( contextValue, suffixLength );

			if ( value == suffix ) {

				return true;

			}

		}

		return false;

	}

}
