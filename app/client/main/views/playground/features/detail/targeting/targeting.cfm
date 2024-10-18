<cfscript>

	featureFlags = request.ioc.get( "core.lib.client.FeatureFlags" );
	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	partialHelper = request.ioc.get( "client.main.lib.PartialHelper" );
	requestHelper = request.ioc.get( "client.main.lib.RequestHelper" );
	utilities = request.ioc.get( "core.lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="url.featureKey" type="string";

	config = partialHelper.getConfig( request.user.email );
	feature = partialHelper.getFeature( config, url.featureKey );
	environments = partialHelper.getEnvironments( config );
	users = partialHelper.getUsers( request.user.email );
	results = getResults( config, feature, environments, users );
	isUniform = getIsUniform( feature, environments, users, results );
	title = "Feature Flag Targeting";

	request.template.title = title;
	request.template.video = "feature-targeting";

	include "./targeting.view.cfm";


	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I determine if the feature is serving the same variant to all users.
	*/
	private boolean function getIsUniform(
		required struct feature,
		required array environments,
		required array users,
		required struct results
		) {

		var engagedIndex = "";

		for ( var environment in environments ) {

			for ( var user in users ) {

				if ( ! engagedIndex.len() ) {

					engagedIndex = results[ user.id ][ environment.key ].variantIndex;
					continue;

				}

				if ( engagedIndex != results[ user.id ][ environment.key ].variantIndex ) {

					return false;

				}

			}

		}

		// If we made it this far, it means that every user is receiving the same variant
		// index in every environment. As such, we're going to consider this feature to be
		// in a uniform state.
		// --
		// Note: this papers-over the notion that custom variant resolutions all show up
		// in the same index (0). But, this is an edge-case.
		return true;

	}


	/**
	* I get the results matrix of the feature x user x environments breakdown.
	*/
	private struct function getResults(
		required struct config,
		required struct feature,
		required array environments,
		required array users
		) {

		var results = {};

		for ( var user in users ) {

			results[ user.id ] = {};

			for ( var environment in environments ) {

				results[ user.id ][ environment.key ] = featureFlags.debugEvaluation(
					config = config,
					featureKey = feature.key,
					environmentKey = environment.key,
					context = partialHelper.getContext( user ),
					fallbackVariant = "FALLBACK"
				);

			}

		}

		return results;

	}

</cfscript>
