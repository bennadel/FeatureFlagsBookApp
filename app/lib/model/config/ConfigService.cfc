component
	output = false
	hint = "I provide service methods for the config entity."
	{

	// Define properties for dependency-injection.
	property name="gateway" ioc:type="lib.model.config.ConfigGateway";
	property name="validation" ioc:type="lib.model.config.ConfigValidation";

	// ---
	// PUBLIC METHODS.
	// ---

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
