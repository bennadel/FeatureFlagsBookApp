<cfscript>

	configValidation = request.ioc.get( "lib.model.config.ConfigValidation" );
	demoLogger = request.ioc.get( "lib.Logger" );
	demoTargeting = request.ioc.get( "lib.demo.DemoTargeting" );
	demoUsers = request.ioc.get( "lib.demo.DemoUsers" );
	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	ui = request.ioc.get( "lib.util.ViewHelper" );
	utilities = request.ioc.get( "lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="attributes.step" type="numeric";
	param name="attributes.highlightAssociation" type="string" default="";

	config = getConfig( request.user.email );
	feature = getFeature( config, request.walkthroughFeature.key );
	environments = getEnvironments( config );
	users = getUsers( request.user.email );
	companies = getCompanies( users );
	results = getResults( config, feature, environments, users );
	journey = getJourney();

	include "./targeting.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the users grouped by company. The authenticated user's company (devteam) is
	* always first; and the rest of the companies are sorted alphabetically.
	*/
	private array function getCompanies( required array users ) {

		var companyIndex = {};

		for ( var user in users ) {

			if ( ! companyIndex.keyExists( user.company.subdomain ) ) {

				companyIndex[ user.company.subdomain ] = {
					subdomain: user.company.subdomain,
					users: []
				};

			}

			companyIndex[ user.company.subdomain ].users.append( user );

		}

		var companies = utilities
			.structValueArray( companyIndex )
			.sort(
				( a, b ) => {

					if ( a.subdomain == "devteam" ) {

						return -1;

					}

					if ( b.subdomain == "devteam" ) {

						return 1;

					}

					return compare( a.subdomain, b.subdomain );

				}
			)
		;

		return companies;

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
	* I get the journey steps for the walk-through.
	*/
	private struct function getJourney() {

		return [
			"2": "Initial Feature State",
			"3": "Enable in Development Environment",
			"4": "Solo Testing in Production",
			"5": "Internal Testing in Production",
			"6": "Beta Testing With Customer",
			"7": "Cautious Roll-Out to 25% of Users",
			"8": "Cautious Roll-Out to 50% of Users",
			"9": "Enable Feature For All Users",
			"10": "Soaking in Production",
			"11": "Time For Your Next Challenge"
		];

	}


	/**
	* I get the results matrix of feature x environments x users.
	*/
	private struct function getResults(
		required struct config,
		required struct feature,
		required array environments,
		required array users
		) {

		var featureFlags = new lib.client.FeatureFlags()
			.withConfig( config )
			.withLogger( demoLogger )
		;
		var results = {};

		for ( var environment in environments ) {

			results[ environment.key ] = {};

			for ( var user in users ) {

				results[ environment.key ][ user.id ] = featureFlags.debugEvaluation(
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
