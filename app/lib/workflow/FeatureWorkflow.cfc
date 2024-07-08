component
	output = false
	hint = "I provide workflow methods for feature flags."
	{

	// Define properties for dependency-injection.
	property name="configService" ioc:type="lib.model.config.ConfigService";
	property name="configValidation" ioc:type="lib.model.config.ConfigValidation";
	property name="demoConfig" ioc:type="lib.demo.DemoConfig";
	property name="demoTargeting" ioc:type="lib.demo.DemoTargeting";
	property name="userService" ioc:type="lib.model.user.UserService";
	property name="utilities" ioc:type="lib.util.Utilities";

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get the features config for the given user.
	*/
	public struct function getConfig( required string email ) {

		var user = userService.getUser( email );
		var config = getConfigForUser( user );

		return config;

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

		if ( config.version != existingConfig.version ) {

			configValidation.throwVersionConflictError();

		}

		// We only wanted to update the version if something has actually changed.
		if ( configService.compareConfigs( config, existingConfig ) ) {

			config.version++;
			configService.saveConfig( user.dataFilename, config );

		}

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
