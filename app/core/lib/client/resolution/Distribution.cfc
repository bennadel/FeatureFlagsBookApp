component
	output = false
	hint = "I implement the distribution resolution strategy."
	{

	/**
	* I initialize the resolution.
	*/
	public void function init() {

		keyConverter = new core.lib.client.util.KeyConverter();

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I return a variant using the distribution resolution strategy.
	*/
	public any function getVariant(
		required string key,
		required any variants,
		required struct resolution
		) {

		var distribution = resolution.distribution;
		var distributionCount = distribution.len();

		var keyIndex = keyConverter.toIndex( key );
		var fromIndex = 1;
		var toIndex = 1;

		for ( var i = 1 ; i <= distributionCount ; i++ ) {

			var weight = distribution[ i ];

			if ( ! weight ) {

				continue;

			}

			toIndex = ( fromIndex + weight - 1 );

			if (
				( keyIndex >= fromIndex ) &&
				( keyIndex <= toIndex )
				) {

				return variants[ i ];

			}

			fromIndex = ( toIndex + 1 );

		}

		// We should never make it here because the distribution MUST total 100. If it
		// doesn't, then something in the configuration is in a bad state.
		throw(
			type = "InvalidResolutionDistribution",
			message = "The configured distribution does not total 100.",
			detail = "No variant could be selected."
		);

	}

}
