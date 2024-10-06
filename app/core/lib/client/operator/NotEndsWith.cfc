component
	output = false
	hint = "I implement the NotEndsWith operator."
	{

	/**
	* I initialize the operator.
	*/
	public void function init() {

		endsWithOperator = new core.lib.client.operator.EndsWith();

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I test to see if the given context value does NOT end with one of the given values.
	*/
	public boolean function test(
		required any contextValue,
		required array values
		) {

		return ! endsWithOperator.test( argumentCollection = arguments );

	}

}
