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

		// If there's no persisted config data file for the user, let's give them a copy
		// of the demo config with the demo targeting applied.
		return demoTargeting.injectRules( demoConfig.getConfig() );

	}

}
