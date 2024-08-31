<cfscript>

	demoLogger = request.ioc.get( "lib.Logger" );
	demoTargeting = request.ioc.get( "lib.demo.DemoTargeting" );
	demoUsers = request.ioc.get( "lib.demo.DemoUsers" );
	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	utilities = request.ioc.get( "lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	// TODO: Move all of this logic into a Partial component.
	request.template.primaryContent = getPartial( request.user.email );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the main partial payload for the view.
	*/
	private struct function getPartial( required string email ) {

		var config = getConfig( email )
		var users = getUsers( email );
		var features = getFeatures( config );
		var environments = getEnvironments( config );
		var breakdown = getBreakdown( config, users, features, environments );

		return {
			users: users,
			features: features,
			environments: environments,
			breakdown: breakdown
		};

	}


	/**
	* I get the variant breakdown for the given users.
	*/
	private struct function getBreakdown(
		required struct config,
		required array users,
		required array features,
		required array environments,
		string fallbackVariant = "FALLBACK"
		) {

		var featureFlags = new lib.client.FeatureFlags()
			.withConfig( config )
			.withLogger( demoLogger )
		;

		var breakdown = [:];

		for ( var environment in environments ) {

			breakdown[ environment.key ] = [:];

			for ( var user in users ) {

				breakdown[ environment.key ][ user.id ] = [:];

				for ( var feature in features ) {

					var result = featureFlags.debugEvaluation(
						featureKey = feature.key,
						environmentKey = environment.key,
						context = demoTargeting.getContext( user ),
						fallbackVariant = fallbackVariant
					);

					breakdown[ environment.key ][ user.id ][ feature.key ] = [
						variantIndex: result.variantIndex,
						variant: serializeJson( result.variant )
					];

				}

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
	* I get the users for the given authenticated user.
	*/
	private function getUsers( required string email ) {

		return demoUsers.getUsers( email );

	}

</cfscript>
