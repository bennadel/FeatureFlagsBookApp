<cfscript>

	demoTargeting = request.ioc.get( "lib.demo.DemoTargeting" );
	demoUsers = request.ioc.get( "lib.demo.DemoUsers" );
	featureFlags = request.ioc.get( "lib.client.FeatureFlags" );
	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	utilities = request.ioc.get( "lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	config = getConfig( request.user.email );
	version = config.version;
	features = getFeatures( config );
	environments = getEnvironments( config );
	users = getUsers( request.user.email );
	results = getResults( config, features, environments, users );
	title = request.template.title = "Feature Flags Playground";

	include "./list.view.cfm";

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
	* I get the results matrix of the features x environments breakdown.
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

				var breakdown = results[ feature.key ][ environment.key ] = [:];

				for ( var variantIndex = 1 ; variantIndex <= feature.variants.len() ; variantIndex++ ) {

					breakdown[ variantIndex ] = 0;

				}

				// The fallback or custom variant count will go last.
				breakdown[ 0 ] = 0;

				for ( var user in users ) {

					var result = featureFlags.debugEvaluation(
						config = config,
						featureKey = feature.key,
						environmentKey = environment.key,
						context = demoTargeting.getContext( user ),
						fallbackVariant = "FALLBACK"
					);

					breakdown[ result.variantIndex ]++;

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
