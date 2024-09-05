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

		var config = getConfig( email );
		var users = getUsers( email );
		var features = getFeatures( config );
		var environments = getEnvironments( config );
		var breakdowns = getBreakdowns( config, users, features, environments );

		return {
			environments: environments,
			features: features,
			breakdowns: breakdowns
		};

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
	* I get the feature / environment / variant allocation breakdown.
	*/
	private struct function getBreakdowns(
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
		// The breakdowns will be keyed by feature and then by environment. Within each
		// breakdown, each entry will contain the variant index and the allocated count.
		var breakdowns = [:];

		for ( var feature in features ) {

			breakdowns[ feature.key ] = [:];

			for ( var environment in environments ) {

				var breakdown = [:];

				// We're starting a "0" since this index will be used to track the
				// fallback and override variant results.
				for ( var i = 0 ; i <= feature.variants.len() ; i++ ) {

					breakdown[ i ] = {
						variantIndex: i,
						count: 0
					};

				}

				for ( var user in users ) {

					var result = featureFlags.debugEvaluation(
						featureKey = feature.key,
						environmentKey = environment.key,
						context = demoTargeting.getContext( user ),
						fallbackVariant = fallbackVariant
					);

					breakdown[ result.variantIndex ].count++;

				}

				breakdowns[ feature.key ][ environment.key ] = utilities.structValueArray( breakdown );

			}

		}

		return breakdowns;

	}


	/**
	* I get the users for the given authenticated user.
	*/
	private array function getUsers( required string email ) {

		return demoUsers.getUsers( email );

	}

</cfscript>
