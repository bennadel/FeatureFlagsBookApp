<cfscript>

	configSerializer = request.ioc.get( "core.lib.model.config.ConfigSerializer" );
	configValidation = request.ioc.get( "core.lib.model.config.ConfigValidation" );
	demoTargeting = request.ioc.get( "core.lib.demo.DemoTargeting" );
	demoUsers = request.ioc.get( "core.lib.demo.DemoUsers" );
	featureFlags = request.ioc.get( "core.lib.client.FeatureFlags" );
	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "core.lib.RequestHelper" );
	utilities = request.ioc.get( "core.lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="url.featureKey" type="string";

	config = getConfig( request.user.email );
	feature = getFeature( config, url.featureKey );
	environments = getEnvironments( config );
	users = getUsers( request.user.email );
	results = getResults( config, feature, environments, users );
	title = request.template.title = "Feature Flag Targeting";

	include "./targeting.view.cfm";


	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the config data for the given authenticated user.
	*/
	private struct function getConfig( required string email ) {

		return featureWorkflow.getConfig( email );

	}


	/**
	* I get the environments for the given config.
	*/
	private array function getEnvironments( required struct config ) {

		return utilities.toEnvironmentsArray( config.environments );

	}


	/**
	* I get the feature for the given key.
	*/
	private struct function getFeature(
		required struct config,
		required string featureKey
		) {

		var features = utilities.toFeaturesArray( config.features );
		var featureIndex = utilities.indexBy( features, "key" );

		if ( ! featureIndex.keyExists( featureKey ) ) {

			configValidation.throwFeatureNotFoundError();

		}

		return featureIndex[ featureKey ];

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

				var result = featureFlags.debugEvaluation(
					config = config,
					featureKey = feature.key,
					environmentKey = environment.key,
					context = demoTargeting.getContext( user ),
					fallbackVariant = "FALLBACK"
				);

				results[ user.id ][ environment.key ] = {
					variantIndex: result.variantIndex,
					ruleIndex: result.matchingRuleIndex
				};

			}

		}

		return results;

	}


	/**
	* I get the users for the given authenticated user.
	*/
	private array function getUsers( required string email ) {

		return demoUsers.getUsers( email );

	}

</cfscript>