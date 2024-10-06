component
	output = false
	hint = "I implement the NotIsOneOf operator."
	{

	/**
	* I initialize the operator.
	*/
	public void function init() {

		isOneOfOperator = new core.lib.client.operator.IsOneOf();

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I test to see if the given context value is NOT one of the given values.
	*/
	public boolean function test(
		required any contextValue,
		required array values
		) {

		return ! isOneOfOperator.test( argumentCollection = arguments );

	}

}
