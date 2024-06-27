component
	output = false
	hint = "I provide workflow methods for feature flags."
	{

	// Define properties for dependency-injection.
	property name="configService" ioc:type="lib.model.config.ConfigService";
	property name="demoConfig" ioc:type="lib.demo.DemoConfig";
	property name="demoTargeting" ioc:type="lib.demo.DemoTargeting";
	property name="userService" ioc:type="lib.model.user.UserService";

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get the features config for the given user.
	*/
	public struct function getConfig( required string email ) {

		var user = userService.getUser( email );
		var maybeConfig = configService.maybeGetConfig( user.dataFilename );

		if ( maybeConfig.exists ) {

			return maybeConfig.value;

		}

		return getDefaultConfigForUser( user );

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* When the user is starting out, they won't have any existing configuration object. In
	* order to not create a lot of duplicate config files, we're just going to provide a
	* default config on-the-fly as needed. Files will only be persisted upon change.
	*/
	private struct function getDefaultConfigForUser( required struct user ) {

		var config = demoConfig.getConfig();
		config.email = user.email;
		config.version = 1;

		return demoTargeting.injectRules( config );

	}

}
