<cfscript>

	demoTargeting = request.ioc.get( "core.lib.demo.DemoTargeting" );
	demoUsers = request.ioc.get( "core.lib.demo.DemoUsers" );
	featureFlags = request.ioc.get( "core.lib.client.FeatureFlags" );
	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	userValidation = request.ioc.get( "core.lib.model.user.UserValidation" );
	utilities = request.ioc.get( "core.lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="url.userID" type="numeric";

	config = getConfig( request.user.email );
	user = getUser( request.user.email, val( url.userID ) );
	context = getContext( user );
	features = getFeatures( config );
	environments = getEnvironments( config );
	breakdown = getBreakdown( config, user, features, environments );
	title = request.template.title = user.name;

	include "./user.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the variant breakdown for the given user.
	*/
	private struct function getBreakdown(
		required struct config,
		required struct user,
		required array features,
		required array environments,
		string fallbackVariant = "FALLBACK"
		) {

		var breakdown = [:];

		for ( var feature in features ) {

			breakdown[ feature.key ] = [:];
			
			for ( var environment in environments ) {

				var result = featureFlags.debugEvaluation(
					config = config,
					featureKey = feature.key,
					environmentKey = environment.key,
					context = demoTargeting.getContext( user ),
					fallbackVariant = fallbackVariant
				);

				breakdown[ feature.key ][ environment.key ] = [
					variantIndex: result.variantIndex,
					variant: result.variant,
					matchingRuleIndex: result.matchingRuleIndex
				];

			}

		}

		return breakdown;

	}


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
	* I get the targeting context for the given user.
	*/
	private struct function getContext( required struct user ) {

		return demoTargeting.getContext( user );

	}


	/**
	* I get the features for the given config.
	*/
	private array function getFeatures( required struct config ) {

		return utilities.toFeaturesArray( config.features );

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
