<cfscript>

	demoLogger = request.ioc.get( "lib.Logger" );
	demoTargeting = request.ioc.get( "lib.demo.DemoTargeting" );
	demoUsers = request.ioc.get( "lib.demo.DemoUsers" );
	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	ui = request.ioc.get( "lib.util.ViewHelper" );
	utilities = request.ioc.get( "lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="url.environmentKey" type="string" default="development";

	config = getConfig( request.user.email );
	features = getFeatures( config );
	environments = getEnvironments( config );
	environment = getEnvironment( environments, url.environmentKey );
	users = getUsers( request.user.email );
	results = getResults( config, features, environment, users );
	title = request.template.title = "Feature Matrix: #environment.name#";

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
	* I get the environment for the given key.
	*/
	private struct function getEnvironment(
		required array environments,
		required string environmentKey
		) {

		var environmentIndex = utilities.indexBy( environments, "key" );

		if ( ! environmentIndex.keyExists( environmentKey ) ) {

			// Todo: Throw a more specific error?
			throw(
				type = "App.NotFound",
				message = "Environment not found."
			);

		}

		return environmentIndex[ environmentKey ];

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
	* I get the results matrix of users x features for the given environment.
	*/
	private struct function getResults(
		required struct config,
		required array features,
		required struct environment,
		required array users
		) {

		var featureFlags = new lib.client.FeatureFlags()
			.withConfig( config )
			.withLogger( demoLogger )
		;
		var results = {};

		for ( var user in users ) {

			results[ user.id ] = {};

			for ( var feature in features ) {

				results[ user.id ][ feature.key ] = featureFlags.debugEvaluation(
					featureKey = feature.key,
					environmentKey = environment.key,
					context = demoTargeting.getContext( user ),
					fallbackVariant = "FALLBACK"
				);

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
