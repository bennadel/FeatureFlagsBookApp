<cfscript>

	demoLogger = request.ioc.get( "lib.Logger" );
	demoTargeting = request.ioc.get( "lib.demo.DemoTargeting" );
	demoUsers = request.ioc.get( "lib.demo.DemoUsers" );
	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	utilities = request.ioc.get( "lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="url.environmentKey" type="string" default="development";

	partial = getPartial(
		email = request.user.email,
		environmentKey = url.environmentKey
	);

	request.template.title = partial.title;

	include "./matrix.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the main partial payload for the view.
	*/
	private struct function getPartial(
		required string email,
		required string  environmentKey
		) {

		var config = getConfig( email );
		var features = getFeatures( config );
		var environments = getEnvironments( config );
		var environment = getEnvironment( environments, environmentKey );
		var users = getUsers( email );
		var results = getResults( config, features, environment, users );
		var title = "Feature Matrix: #environment.name#";

		return {
			features: features,
			environments: environments,
			environment: environment,
			users: users,
			results: results,
			title: title
		};

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
	* I get the users for the given authenticated user.
	*/
	private array function getUsers( required string email ) {

		return demoUsers.getUsers( email );

	}

</cfscript>
