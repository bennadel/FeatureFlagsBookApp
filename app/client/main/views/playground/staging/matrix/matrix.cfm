<cfscript>

	featureFlags = request.ioc.get( "core.lib.client.FeatureFlags" );
	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	partialHelper = request.ioc.get( "client.main.lib.PartialHelper" );
	ui = request.ioc.get( "client.main.lib.ViewHelper" );
	utilities = request.ioc.get( "core.lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	config = partialHelper.getConfig( request.user.email );
	features = partialHelper.getFeatures( config );
	environments = partialHelper.getEnvironments( config );
	users = partialHelper.getUsers( request.user.email );
	results = getResults( config, features, environments, users );
	isUniform = getIsUniform( features, environments, results );
	title = "Feature Matrix";

	request.template.title = title;
	request.template.video = "staging-matrix";

	include "./matrix.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the index of uniform features - the features in which the same variant is
	* being allocated in all environments.
	*/
	private struct function getIsUniform(
		required array features,
		required array environments,
		required struct results
		) {

		var uniformIndex = {};

		features.each(
			( feature ) => {

				uniformIndex[ feature.key ] = false;

				var engagedVariantIndex = -1;

				for ( var environment in environments ) {

					for ( var entry in utilities.toEntries( results[ feature.key ][ environment.key ] ) ) {

						if ( engagedVariantIndex == -1 ) {

							engagedVariantIndex = entry.value.variantIndex;
							continue;

						}

						if ( engagedVariantIndex != entry.value.variantIndex ) {

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
				uniformIndex[ feature.key ] = true;

			}
		);

		return uniformIndex;

	}


	/**
	* I get the results matrix of features x environments x users.
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

				results[ feature.key ][ environment.key ] = {};

				for ( var user in users ) {

					results[ feature.key ][ environment.key ][ user.id ] = featureFlags.debugEvaluation(
						config = config,
						featureKey = feature.key,
						environmentKey = environment.key,
						context = partialHelper.getContext( user ),
						fallbackVariant = "FALLBACK"
					);

				}

			}

		}

		return results;

	}

</cfscript>
