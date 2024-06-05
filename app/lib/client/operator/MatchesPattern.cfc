component
	output = false
	hint = "I implement the MatchesPattern operator."
	{

	/**
	* I test to see if the given context value matches one of the given RegEx values.
	*/
	public boolean function test(
		required any contextValue,
		required array values
		) {

		for ( var value in values ) {

			if ( reFind( value, contextValue ) ) {

				return true;

			}

		}

		return false;

	}

}
