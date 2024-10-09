component
	output = false
	hint = "I provide common methods for use in view partials."
	{

	// Define properties for dependency-injection.
	property name="configValidation" ioc:type="core.lib.model.config.ConfigValidation";
	property name="demoTargeting" ioc:type="core.lib.demo.DemoTargeting";
	property name="demoUsers" ioc:type="core.lib.demo.DemoUsers";
	property name="featureWorkflow" ioc:type="core.lib.workflow.FeatureWorkflow";
	property name="userValidation" ioc:type="core.lib.model.user.UserValidation";
	property name="utilities" ioc:type="core.lib.util.Utilities";

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get the users grouped by company. The authenticated user's company (devteam) is
	* always first; and the rest of the companies are sorted alphabetically.
	*/
	public array function getCompanies( required array users ) {

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
	public struct function getConfig( required string email ) {

		return featureWorkflow.getConfig( email );

	}


	/**
	* I get the targeting context for the given user.
	*/
	public struct function getContext( required struct user ) {

		return demoTargeting.getContext( user );

	}


	/**
	* I get the environment for the given key.
	*/
	public struct function getEnvironment(
		required struct config,
		required string environmentKey
		) {

		var environments = getEnvironments( config );
		var environmentIndex = utilities.indexBy( environments, "key" );

		if ( ! environmentIndex.keyExists( environmentKey ) ) {

			configValidation.throwTargetingNotFoundError();

		}

		return environmentIndex[ environmentKey ];

	}


	/**
	* I get the environments for the given config.
	*/
	public array function getEnvironments( required struct config ) {

		return utilities.toEnvironmentsArray( config.environments );

	}


	/**
	* I get the feature for the given key.
	*/
	public struct function getFeature(
		required struct config,
		required string featureKey
		) {

		var features = getFeatures( config );
		var featureIndex = utilities.indexBy( features, "key" );

		if ( ! featureIndex.keyExists( featureKey ) ) {

			configValidation.throwFeatureNotFoundError();

		}

		return featureIndex[ featureKey ];

	}


	/**
	* I get the features for the given config.
	*/
	public array function getFeatures( required struct config ) {

		return utilities.toFeaturesArray( config.features );

	}


	/**
	* I get the rule at the given index.
	*/
	public struct function getRule(
		required struct feature,
		required struct environment,
		required numeric ruleIndex
		) {

		var rules = feature.targeting[ environment.key ].rules;

		if ( ! rules.isDefined( ruleIndex ) ) {

			configValidation.throwRuleNotFoundError();

		}

		return rules[ ruleIndex ];

	}


	/**
	* I get the user for the given authenticated user.
	*/
	public struct function getUser(
		required string email,
		required numeric userID
		) {

		var users = getUsers( email );
		var userIndex = utilities.indexBy( users, "id" );

		if ( ! userIndex.keyExists( userID ) ) {

			userValidation.throwUserNotFoundError();

		}

		return userIndex[ userID ];

	}


	/**
	* I get the users for the given authenticated user.
	*/
	public array function getUsers( required string email ) {

		return demoUsers.getUsers( email );

	}


}
