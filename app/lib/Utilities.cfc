component
	output = false
	hint = "I provide miscellaneous utility functions."
	{

	/**
	* I index the given collection using the given key as the associative entry.
	*/
	public struct function indexBy(
		required array collection,
		required string key
		) {

		var index = {};

		for ( var element in collection ) {

			index[ element[ key ] ] = element;

		}

		return index;

	}

}
