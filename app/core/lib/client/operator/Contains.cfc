component
	output = false
	hint = "I implement the Contains operator."
	{

	/**
	* I test to see if the given context value contains one of the given values.
	*/
	public boolean function test(
		required any contextValue,
		required array values
		) {

		for ( var value in values ) {

			if ( findNoCase( value, contextValue ) ) {

				return true;

			}

		}

		return false;

	}

}
