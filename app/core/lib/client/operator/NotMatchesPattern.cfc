component
	output = false
	hint = "I implement the NotMatchesPattern operator."
	{

	// Define properties for dependency-injection.
	property name="matchesPatternOperator" ioc:type="core.lib.client.operator.MatchesPattern";

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I test to see if the given context value does NOT match one of the given RegEx
	* values.
	*/
	public boolean function test(
		required any contextValue,
		required array values
		) {

		return ! matchesPatternOperator.test( argumentCollection = arguments );

	}

}
