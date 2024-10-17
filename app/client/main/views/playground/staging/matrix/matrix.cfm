<cfscript>

	featureFlags = request.ioc.get( "core.lib.client.FeatureFlags" );
	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	partialHelper = request.ioc.get( "client.main.lib.PartialHelper" );
	ui = request.ioc.get( "client.main.lib.ViewHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	config = partialHelper.getConfig( request.user.email );
	features = partialHelper.getFeatures( config );
	environments = partialHelper.getEnvironments( config );
	users = partialHelper.getUsers( request.user.email );
	results = getResults( config, features, environments, users );
	title = "Feature Matrix";

	request.template.title = title;
	request.template.video = "staging-matrix";

	include "./matrix.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

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
