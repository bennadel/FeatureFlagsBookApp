<cfscript>

	demoLogger = request.ioc.get( "lib.Logger" );
	demoTargeting = request.ioc.get( "lib.demo.DemoTargeting" );
	demoUsers = request.ioc.get( "lib.demo.DemoUsers" );
	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	utilities = request.ioc.get( "lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="url.userID" type="numeric";

	config = getConfig( request.user.email );
	user = getUser( request.user.email, val( url.userID ) );
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

		var featureFlags = new lib.client.FeatureFlags()
			.withConfig( config )
			.withLogger( demoLogger )
		;

		var breakdown = [:];

		for ( var feature in features ) {

			breakdown[ feature.key ] = [:];
			
			for ( var environment in environments ) {

				var result = featureFlags.debugEvaluation(
					featureKey = feature.key,
					environmentKey = environment.key,
					context = demoTargeting.getContext( user ),
					fallbackVariant = fallbackVariant
				);

				breakdown[ feature.key ][ environment.key ] = [
					variantIndex: result.variantIndex,
					variant: result.variant
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

			// Todo: Throw a more specific error?
			throw(
				type = "App.NotFound",
				message = "User not found."
			);

		}

		return userIndex[ userID ];

	}

</cfscript>
