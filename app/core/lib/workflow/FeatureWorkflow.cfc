component
	output = false
	hint = "I provide workflow methods for feature flags."
	{

	// Define properties for dependency-injection.
	property name="configService" ioc:type="core.lib.model.config.ConfigService";
	property name="configValidation" ioc:type="core.lib.model.config.ConfigValidation";
	property name="demoConfig" ioc:type="core.lib.demo.DemoConfig";
	property name="demoTargeting" ioc:type="core.lib.demo.DemoTargeting";
	property name="userService" ioc:type="core.lib.model.user.UserService";
	property name="utilities" ioc:type="core.lib.util.Utilities";

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I add a new feature with the given settings.
	*/
	public void function addFeature(
		required string email,
		required string featureKey,
		required string type,
		required string description,
		required array variants,
		required numeric defaultSelection
		) {

		var user = userService.getUser( email );
		var config = getConfigForUser( user );

		if ( config.features.keyExists( featureKey ) ) {

			configValidation.throwFeatureConflictError();

		}

		config.features[ featureKey ] = [
			type: type,
			description: description,
			variants: variants,
			defaultSelection: defaultSelection,
			targeting: config.environments.map(
				( environmentKey ) => {

					return {
						resolution: [
							type: "selection",
							selection: defaultSelection
						],
						rulesEnabled: false,
						rules: []
					};

				}
			)
		];

		configService.saveConfig( user.dataFilename, config );

	}


	/**
	* I remove all the rules and apply a default resolution using selection.
	*/
	public void function clearConfig( required string email ) {

		var user = userService.getUser( email );
		var config = getConfigForUser( user );

		config.features.each(
			( featureKey, featureSettings ) => {

				featureSettings.targeting.each(
					( environmentKey, environmentSettings ) => {

						environmentSettings.resolution = [
							type: "selection",
							selection: featureSettings.defaultSelection
						];
						environmentSettings.rulesEnabled = false;
						environmentSettings.rules = [];

					}
				);

			}
		);

		configService.saveConfig( user.dataFilename, config );

	}


	/**
	* I clear all the rules in the given feature.
	*/
	public void function clearFeature(
		required string email,
		required string featureKey
		) {

		var user = userService.getUser( email );
		var config = getConfigForUser( user );

		if ( ! config.features.keyExists( featureKey ) ) {

			configValidation.throwFeatureNotFoundError();

		}

		var targeting = config.features[ featureKey ].targeting;

		for ( var environmentKey in targeting ) {

			targeting[ environmentKey ].rulesEnabled = false;
			targeting[ environmentKey ].rules = [];

		}

		configService.saveConfig( user.dataFilename, config );

	}


	/**
	* I delete the feature with the given key.
	*/
	public void function deleteFeature(
		required string email,
		required string featureKey
		) {

		var user = userService.getUser( email );
		var config = getConfigForUser( user );

		if ( ! config.features.keyExists( featureKey ) ) {

			configValidation.throwFeatureNotFoundError();

		}

		config.features.delete( featureKey );
		configService.saveConfig( user.dataFilename, config );

	}


	/**
	* I delete the feature rule at the given index.
	*/
	public void function deleteRule(
		required string email,
		required string featureKey,
		required string environmentKey,
		required numeric ruleIndex
		) {

		var user = userService.getUser( email );
		var config = getConfigForUser( user );

		if ( ! config.features.keyExists( featureKey ) ) {

			configValidation.throwFeatureNotFoundError();

		}

		var targeting = config.features[ featureKey ].targeting;

		if ( ! targeting.keyExists( environmentKey ) ) {

			configValidation.throwTargetingNotFoundError();

		}

		var environment = targeting[ environmentKey ];

		if ( ! environment.rules.isDefined( ruleIndex ) ) {

			configValidation.throwRuleNotFoundError();

		}

		environment.rules.deleteAt( ruleIndex );
		configService.saveConfig( user.dataFilename, config );

	}


	/**
	* I get the features config for the given user.
	*/
	public struct function getConfig( required string email ) {

		var user = userService.getUser( email );
		var config = getConfigForUser( user );

		return config;

	}


	/**
	* I reset the features config for the given user (this just deletes the persisted
	* configuration file).
	*/
	public void function resetConfig( required string email ) {

		var user = userService.getUser( email );

		configService.deleteConfig( user.dataFilename );

	}


	/**
	* I update the features config for the given user.
	*/
	public void function updateConfig(
		required string email,
		required struct config
		) {

		var user = userService.getUser( email );
		var existingConfig = getConfigForUser( user );

		config = configValidation.testConfig( config );

		if ( config.email != user.email ) {

			configValidation.throwEmailConflictError();

		}

		configService.saveConfig( user.dataFilename, config );

	}


	/**
	* I update the default resolution in the given targeting environment.
	*/
	public void function updateDefaultResolution(
		required string email,
		required string featureKey,
		required string environmentKey,
		required struct resolution
		) {

		var user = userService.getUser( email );
		var config = getConfigForUser( user );

		if ( ! config.features.keyExists( featureKey ) ) {

			configValidation.throwFeatureNotFoundError();

		}

		var targeting = config.features[ featureKey ].targeting;

		if ( ! targeting.keyExists( environmentKey ) ) {

			configValidation.throwTargetingNotFoundError();

		}

		targeting[ environmentKey ].resolution = resolution;
		configService.saveConfig( user.dataFilename, config );

	}


	/**
	* I update the feature settings for the given user.
	*/
	public void function updateFeature(
		required string email,
		required string featureKey,
		required struct feature
		) {

		var user = userService.getUser( email );
		var existingConfig = getConfigForUser( user );

		if ( ! existingConfig.features.keyExists( featureKey ) ) {

			configValidation.throwFeatureNotFoundError();

		}

		var config = duplicate( existingConfig );
		config.features[ featureKey ] = feature;
		config = configValidation.testConfig( config );
		configService.saveConfig( user.dataFilename, config );

	}


	/**
	* I update the rule in the given targeting environment.
	*/
	public void function updateRule(
		required string email,
		required string featureKey,
		required string environmentKey,
		required numeric ruleIndex,
		required struct rule
		) {

		var user = userService.getUser( email );
		var config = getConfigForUser( user );

		if ( ! config.features.keyExists( featureKey ) ) {

			configValidation.throwFeatureNotFoundError();

		}

		var targeting = config.features[ featureKey ].targeting;

		if ( ! targeting.keyExists( environmentKey ) ) {

			configValidation.throwTargetingNotFoundError();

		}

		var environment = targeting[ environmentKey ];

		if ( ruleIndex && ! environment.rules.isDefined( ruleIndex ) ) {

			configValidation.throwRuleNotFoundError();

		}

		if ( ruleIndex ) {

			environment.rules[ ruleIndex ] = rule;

		} else {

			environment.rules.append( rule );

		}

		configService.saveConfig( user.dataFilename, config );

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I get the config for the given user (falling back to the demo config if no persisted
	* config exists yet).
	*/
	private function getConfigForUser( required struct user ) {

		var maybeConfig = configService.maybeGetConfig( user.dataFilename );

		if ( maybeConfig.exists ) {

			return maybeConfig.value;

		}

		return getDefaultConfigForUser( user );

	}


	/**
	* When the user is starting out, they won't have any existing configuration object. In
	* order to not create a lot of duplicate config files, we're just going to provide a
	* default config on-the-fly as needed. Files will only be persisted upon change.
	*/
	private struct function getDefaultConfigForUser( required struct user ) {

		return demoTargeting.injectRules( demoConfig.getConfig( user.email ) );

	}

}
