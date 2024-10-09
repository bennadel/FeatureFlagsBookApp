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

		config = configValidation.testConfig( config );
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
