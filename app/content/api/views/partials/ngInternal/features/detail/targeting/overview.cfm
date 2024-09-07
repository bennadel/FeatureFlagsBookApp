<cfscript>

	demoLogger = request.ioc.get( "lib.Logger" );
	demoTargeting = request.ioc.get( "lib.demo.DemoTargeting" );
	demoUsers = request.ioc.get( "lib.demo.DemoUsers" );
	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	utilities = request.ioc.get( "lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="url.featureKey" type="string";

	// TODO: Move all of this logic into a Partial component.
	request.template.primaryContent = getPartial(
		email = request.user.email,
		featureKey = url.featureKey.trim()
	);

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the main partial payload for the view.
	*/
	private struct function getPartial(
		required string email,
		required string featureKey
		) {

		var config = getConfig( email );
		var feature = getFeature( config, featureKey );
		var environments = getEnvironments( config );
		var users = getUsers( email );
		var breakdown = getBreakdown( config, feature, environments, users );

		return {
			feature: feature,
			environments: environments,
			breakdown: breakdown
		};

	}


	/**
	* I get the feature / environment / variant allocation breakdown.
	*/
	private struct function getBreakdown(
		required struct config,
		required struct feature,
		required array environments,
		required array users,
		string fallbackVariant = "FALLBACK"
		) {

		var featureFlags = new lib.client.FeatureFlags()
			.withConfig( config )
			.withLogger( demoLogger )
		;
		var breakdown = {
			environments: environments,
			users: []
		};

		for ( var user in users ) {

			var entry = {
				id: user.id,
				environments: [:]
			};

			for ( var environment in environments ) {

				var result = featureFlags.debugEvaluation(
					featureKey = feature.key,
					environmentKey = environment.key,
					context = demoTargeting.getContext( user ),
					fallbackVariant = fallbackVariant
				);

				entry.environments[ environment.key ] = {
					ruleIndex: result.matchingRuleIndex,
					variantIndex: result.variantIndex
				};

			}

			breakdown.users.append( entry );

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
	* I get the feature for the given config.
	*/
	private struct function getFeature(
		required struct config,
		required string featureKey
		) {

		var features = utilities.toFeaturesArray( config.features );
		var featureIndex = utilities.indexBy( features, "key" );

		if ( ! featureIndex.keyExists( featureKey ) ) {

			// Todo: Throw a more specific error?
			throw(
				type = "App.NotFound",
				message = "Feature flag not found."
			);

		}

		return featureIndex[ featureKey ];

	}


	/**
	* I get the users for the given authenticated user.
	*/
	private array function getUsers( required string email ) {

		return demoUsers.getUsers( email );

	}

</cfscript>
