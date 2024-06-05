component
	output = false
	hint = "I implement the NotContains operator."
	{

	/**
	* I initialize the operator.
	*/
	public void function init() {

		containsOperator = new lib.client.operator.Contains();

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I test to see if the given context value does NOT contain one of the given values.
	*/
	public boolean function test(
		required any contextValue,
		required array values
		) {

		return ! containsOperator.test( argumentCollection = arguments );

	}

}
