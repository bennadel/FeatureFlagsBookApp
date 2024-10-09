<cfscript>

	featureFlags = request.ioc.get( "core.lib.client.FeatureFlags" );
	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	partialHelper = request.ioc.get( "client.main.views.common.lib.PartialHelper" );
	utilities = request.ioc.get( "core.lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	config = partialHelper.getConfig( request.user.email );
	features = partialHelper.getFeatures( config );
	environments = partialHelper.getEnvironments( config );
	users = partialHelper.getUsers( request.user.email );
	results = getResults( config, features, environments, users );
	uniformFeatures = getUniformFeatures( features, environments, results );
	title = "Feature Flags Playground";

	request.template.title = title;
	request.template.video = "features-list";

	include "./list.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the results matrix of the features x environments breakdown.
	*/
	private struct function getResults(
		required struct config,
		required array features,
		required array environments,
		required array users
		) {

		var results = {};

		for ( var feature in features ) {

			results[ feature.key ] = {};

			for ( var environment in environments ) {

				var breakdown = results[ feature.key ][ environment.key ] = [:];

				// Default the variant index counts.
				for ( var variantIndex = 1 ; variantIndex <= feature.variants.len() ; variantIndex++ ) {

					breakdown[ variantIndex ] = 0;

				}

				// The fallback or custom variant count will go last.
				breakdown[ 0 ] = 0;

				for ( var user in users ) {

					var result = featureFlags.debugEvaluation(
						config = config,
						featureKey = feature.key,
						environmentKey = environment.key,
						context = partialHelper.getContext( user ),
						fallbackVariant = "FALLBACK"
					);

					breakdown[ result.variantIndex ]++;

				}

			}

		}

		return results;

	}


	/**
	* I get the uniform features - the features in which the same variant is being
	* allocated in all environments.
	*/
	private array function getUniformFeatures(
		required array features,
		required array environments,
		required struct results
		) {

		return features.filter(
			( feature ) => {

				var fullyEngagedKey = "";

				for ( var environment in environments ) {

					for ( var entry in utilities.toEntries( results[ feature.key ][ environment.key ] ) ) {

						if ( ! entry.value ) {

							continue;

						}

						// If any variant in any environment is being served at a sub-100
						// allocation, then then feature is not uniform.
						if ( entry.value < 100 ) {

							return false;

						}

						if ( ! fullyEngagedKey.len() ) {

							fullyEngagedKey = entry.key;
							continue;

						}

						if ( fullyEngagedKey != entry.key ) {

							return false;

						}

					}

				}

				// If we made it this far, it means that every environment had the same
				// fully-engaged variant index. As such, we're going to consider this
				// feature to be in a uniform state.
				// --
				// Note: this papers-over the notion that custom variant resolutions all
				// show up in the same index (0). But, this is an edge-case.
				return true;

			}
		);

	}

</cfscript>
