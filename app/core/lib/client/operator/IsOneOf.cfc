component
	output = false
	hint = "I implement the IsOneOf operator."
	{

	/**
	* I test to see if the given context value is one of the given values.
	*/
	public boolean function test(
		required any contextValue,
		required array values
		) {

		for ( var value in values ) {

			if ( value == contextValue ) {

				return true;

			}

		}

		return false;

	}

}
