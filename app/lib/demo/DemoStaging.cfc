component
	output = false
	hint = "I provide feature flag staging for the demo (ie which feature variants are being allocated)."
	{

	// Define properties for dependency-injection.
	property name="demoLogger" ioc:type="lib.Logger";
	property name="demoTargeting" ioc:type="lib.demo.DemoTargeting";
	property name="demoUsers" ioc:type="lib.demo.DemoUsers";
	property name="utilities" ioc:type="lib.util.Utilities";

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I return the full variant allocation breakdown for the given features, environments,
	* and users.
	*/
	public struct function getBreakdown(
		required struct config,
		required array users,
		required array features,
		required array environments,
		string fallbackVariant = "FALLBACK"
		) {

		var featureFlags = new lib.client.FeatureFlags()
			.withConfig( config )
			.withLogger( demoLogger )
		;
		// The breakdowns will be keyed by feature and then by environment. Within each
		// breakdown, each entry will contain the variant index and the allocated count.
		var breakdowns = [:];

		for ( var feature in features ) {

			breakdowns[ feature.key ] = [:];

			for ( var environment in environments ) {

				var breakdown = [:];

				// We're starting a "0" since this index will be used to track the
				// fallback and override variant results.
				for ( var i = 0 ; i <= feature.variants.len() ; i++ ) {

					breakdown[ i ] = {
						variantIndex: i,
						count: 0
					};

				}

				for ( var user in users ) {

					var result = featureFlags.debugEvaluation(
						featureKey = feature.key,
						environmentKey = environment.key,
						context = demoTargeting.getContext( user ),
						fallbackVariant = fallbackVariant
					);

					breakdown[ result.variantIndex ].count++;

				}

				breakdowns[ feature.key ][ environment.key ] = utilities.structValueArray( breakdown );

			}

		}

		return breakdowns;

	}

}
