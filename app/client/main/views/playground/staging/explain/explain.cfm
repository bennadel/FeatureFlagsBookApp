<cfscript>

	configValidation = request.ioc.get( "core.lib.model.config.ConfigValidation" );
	demoTargeting = request.ioc.get( "core.lib.demo.DemoTargeting" );
	demoUsers = request.ioc.get( "core.lib.demo.DemoUsers" );
	featureFlags = request.ioc.get( "core.lib.client.FeatureFlags" );
	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	userValidation = request.ioc.get( "core.lib.model.user.UserValidation" );
	utilities = request.ioc.get( "core.lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="url.userID" type="numeric";
	param name="url.featureKey" type="string";
	param name="url.environmentKey" type="string";


	config = getConfig( request.user.email );
	user = getUser( request.user.email, val( url.userID ) );
	feature = getFeature( config, url.featureKey );
	environment = getEnvironment( config, url.environmentKey );
	result = getResult( config, user, feature, environment );
	title = "Variant Allocation Explanation";

	request.template.title = title;
	request.template.video = "staging-explain";

	include "./explain.view.cfm";

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
		required struct config,
		required string environmentKey
		) {

		var environments = utilities.toEnvironmentsArray( config.environments );
		var environmentIndex = utilities.indexBy( environments, "key" );

		if ( ! environmentIndex.keyExists( environmentKey ) ) {

			configValidation.throwTargetingNotFoundError();

		}

		return environmentIndex[ environmentKey ];

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
	* I get the feature targeting result for the given user, feature, environment.
	*/
	private struct function getResult(
		required struct config,
		required struct user,
		required struct feature,
		required struct environment
		) {

		return featureFlags.debugEvaluation(
			config = config,
			featureKey = feature.key,
			environmentKey = environment.key,
			context = demoTargeting.getContext( user ),
			fallbackVariant = "FALLBACK"
		);

	}


	/**
	* I get the user for the given authenticated user.
	*/
	private struct function getUser(
		required string email,
		required numeric userID
		) {

		var users = demoUsers.getUsers( email );
		var userIndex = utilities.indexBy( users, "id" );

		if ( ! userIndex.keyExists( userID ) ) {

			userValidation.throwUserNotFoundError();

		}

		return userIndex[ userID ];

	}

</cfscript>
