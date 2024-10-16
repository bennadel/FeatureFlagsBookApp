component
	output = false
	hint = "I implement the NotStartsWith operator."
	{

	// Define properties for dependency-injection.
	property name="startsWithOperator" ioc:type="core.lib.client.operator.StartsWith";

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I test to see if the given context value does NOT start with one of the given
	* values.
	*/
	public boolean function test(
		required any contextValue,
		required array values
		) {

		return ! startsWithOperator.test( argumentCollection = arguments );

	}

}
