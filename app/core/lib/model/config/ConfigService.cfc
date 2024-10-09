component
	output = false
	hint = "I provide service methods for the config entity."
	{

	// Define properties for dependency-injection.
	property name="gateway" ioc:type="core.lib.model.config.ConfigGateway";
	property name="serializer" ioc:type="core.lib.model.config.ConfigSerializer";
	property name="validation" ioc:type="core.lib.model.config.ConfigValidation";

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I delete the config saved at the given filename.
	*/
	public void function deleteConfig( required string dataFilename ) {

		gateway.deleteConfig( dataFilename );

	}


	/**
	* I return a Maybe result for the given config filename.
	*/
	public struct function maybeGetConfig( required string dataFilename ) {

		var result = gateway.getConfig( dataFilename );

		if ( result.isEmpty() ) {

			return {
				exists: false
			};

		}

		return {
			exists: true,
			value: result
		};

	}


	/**
	* I save the given config data to the given filename.
	*/
	public void function saveConfig(
		required string dataFilename,
		required struct config
		) {

		config = validation.testConfig( config );

		gateway.saveConfig( dataFilename, config );

	}

}
