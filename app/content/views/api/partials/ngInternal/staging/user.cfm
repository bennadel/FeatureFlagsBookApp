<cfscript>

	demoLogger = request.ioc.get( "lib.Logger" );
	demoTargeting = request.ioc.get( "lib.demo.DemoTargeting" );
	demoUsers = request.ioc.get( "lib.demo.DemoUsers" );
	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	utilities = request.ioc.get( "lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="url.userID" type="numeric";

	// TODO: Move all of this logic into a Partial component.
	request.template.primaryContent = getPartial(
		email = request.user.email,
		userID = val( url.userID )
	);

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the main partial payload for the view.
	*/
	private struct function getPartial(
		required string email,
		required numeric userID
		) {

		var config = getConfig( email );
		var user = getUser( email, userID );
		var features = getFeatures( config );
		var environments = getEnvironments( config );
		var breakdown = getBreakdown( config, user, features, environments );

		return {
			user: user,
			features: features,
			environments: environments,
			breakdown: breakdown
		};

	}


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
					variant: serializeJson( result.variant )
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
