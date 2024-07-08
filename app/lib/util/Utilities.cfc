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


	/**
	* For look-up purposes, the environments collection is stored as a Struct. However,
	* for rendering the user interface, it can be easier to work with an array. This
	* method converts the environments struct-data into array-data.
	*/
	public array function toEnvironmentsArray( required struct environments ) {

		// Note: I'm depending on the fact that the environments are stored as an ordered-
		// struct; and therefore, the keys are returned in the same order in which they
		// were defined (which maps the logical progression of code through a deployment).
		var results = environments
			.keyArray()
			.map(
				( key ) => {

					var environment = environments[ key ];

					return {
						key: key,
						...environment
					};

				}
			)
		;

		return results;

	}


	/**
	* For look-up purposes, the features collection is stored as a Struct. However, for
	* rendering the user interface, it can be easier to work with an array. This method
	* converts the features struct-data into key-sorted array-data.
	*/
	public array function toFeaturesArray( required struct features ) {

		var results = features
			.keyArray()
			.sort( "textnocase" )
			.map(
				( key ) => {

					var feature = features[ key ];

					return {
						key: key,
						...feature
					};

				}
			)
		;

		return results;

	}

}
