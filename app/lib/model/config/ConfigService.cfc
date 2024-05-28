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

		// Caution: We're duplicating the config object so that we can detach it from the
		// calling context. We're going to be normalizing the data and preparing it for
		// serialization. As such, we don't want to corrupt any references that may still
		// be in use within the calling context.
		config = validation.testConfig( duplicate( config ) );

		gateway.saveConfig( dataFilename, config );

	}

}
