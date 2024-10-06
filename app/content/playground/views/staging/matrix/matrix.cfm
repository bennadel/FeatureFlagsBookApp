<cfscript>

	demoTargeting = request.ioc.get( "core.lib.demo.DemoTargeting" );
	demoUsers = request.ioc.get( "core.lib.demo.DemoUsers" );
	featureFlags = request.ioc.get( "core.lib.client.FeatureFlags" );
	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	ui = request.ioc.get( "core.lib.util.ViewHelper" );
	utilities = request.ioc.get( "core.lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	config = getConfig( request.user.email );
	features = getFeatures( config );
	environments = getEnvironments( config );
	users = getUsers( request.user.email );
	results = getResults( config, features, environments, users );
	title = request.template.title = "Feature Matrix";

	include "./matrix.view.cfm";

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
	* I get the features for the given config.
	*/
	private array function getFeatures( required struct config ) {

		return utilities.toFeaturesArray( config.features );

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
						context = demoTargeting.getContext( user ),
						fallbackVariant = "FALLBACK"
					);

				}

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
