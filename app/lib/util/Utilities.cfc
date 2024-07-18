component
	output = false
	hint = "I provide miscellaneous utility functions."
	{

	/**
	* I return the given key using the internal key-casing.
	*/
	public string function getStructKey(
		required struct target,
		required string key
		) {

		// The native structKeyArray() function will return the keys using their internal
		// representation. If we can find a case-INSENSITIVE match, we can return the
		// original key to get the internal key-casing.
		for ( var originalKey in structKeyArray( target ) ) {

			if ( originalKey == key ) {

				return originalKey;

			}

		}

		throw(
			type = "MissingStructKey",
			message = "Key [#key#] doesn't exist."
		);

	}


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
	* I convert the given collection to an array of entries. Each entry has (index, key,
	* and value) properties.
	*/
	public array function toEntries( required any collection ) {

		if ( isArray( collection ) ) {

			return collection.map(
				( value, i ) => {

					return {
						index: i,
						key: i,
						value: value
					};

				}
			);

		}

		if ( isStruct( collection ) ) {

			return collection.keyArray().map(
				( key, i ) => {

					return {
						index: i,
						key: key,
						value: collection[ key ]
					};

				}
			);

		}

		throw(
			type = "UnsupportedCollectionType",
			message = "Cannot get entries for unsupported collection type."
		);

	}


	/**
	* For look-up purposes, the environments collection is stored as a Struct. However,
	* for rendering the user interface, it can be easier to work with an array. This
	* method converts the environments struct-data into array-data.
	*/
	public array function toEnvironmentsArray( required struct environments ) {

		// In theory, the user can add and remove environments. For aesthetic reasons, I
		// always want Dev and Prod to be the first two elements.
		// --
		// Note: This counters the fact that Adobe ColdFusion parses JSON objects into
		// unordered structs, which lose their original, defining key sort.
		var prioritySorting = reflectIndices([ "development", "production" ]);

		// Note: I'm depending on the fact that the environments are stored as an ordered-
		// struct; and therefore, the keys are returned in the same order in which they
		// were defined (which maps the logical progression of code through a deployment).
		var results = environments
			.keyArray()
			.sort(
				( a, b ) => {

					var indexA = ( prioritySorting[ a ] ?: 0 );
					var indexB = ( prioritySorting[ b ] ?: 0 );

					if ( indexA && indexB ) {

						return ( indexA - indexB );

					} else if ( indexA ) {

						return -1;

					} else if ( indexB ) {

						return 1;

					}

					return compareNoCase( a, b );

				}
			)
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

		// While the user can add their own feature flags, I expect most users to just
		// play with the feature flags that are already there. And, in that case, I want
		// the flags to be listed in the same order in which I originally defined them.
		// --
		// Note: This counters the fact that Adobe ColdFusion parses JSON objects into
		// unordered structs, which lose their original, defining key sort.
		var prioritySorting = reflectIndices([
			"product-TICKET-111-reporting",
			"product-TICKET-222-2fa",
			"product-TICKET-333-themes",
			"product-TICKET-444-homepage-sql-performance",
			"product-TICKET-555-discount-pricing",
			"product-TICKET-666-request-proxy",
			"product-TICKET-777-max-team-size",
			"operations-request-rate-limit",
			"operations-user-rate-limit",
			"operations-min-log-level"
		]);

		var results = features
			.keyArray()
			.sort(
				( a, b ) => {

					var indexA = ( prioritySorting[ a ] ?: 0 );
					var indexB = ( prioritySorting[ b ] ?: 0 );

					if ( indexA && indexB ) {

						return ( indexA - indexB );

					} else if ( indexA ) {

						return -1;

					} else if ( indexB ) {

						return 1;

					}

					return compareNoCase( a, b );

				}
			)
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


	/**
	* I reflect the array of simple values into a struct that maps each value to its index
	* in the given array.
	*/
	public struct function reflectIndices( required array values ) {

		var indices = [:];

		values.each(
			( value, i ) => {

				indices[ value ] = i;

			}
		);

		return indices;

	}

}
