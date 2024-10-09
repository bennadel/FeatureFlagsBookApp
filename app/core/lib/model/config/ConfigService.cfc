component
	output = false
	hint = "I provide service methods for the config entity."
	{

	// Define properties for dependency-injection.
	property name="clock" ioc:type="core.lib.util.Clock";
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

		// TEMPORARY: I removed the notion of a version and now I'm adding it back; but,
		// there are some persisted JSON files that no longer have it and I want to ensure
		// that it exists in the data structure before I return it. Once those JSON files
		// have been cycled, I can remove this line of code.
		param name="result.version" type="numeric" default=1;

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
		// Note: I don't know if I love the idea of the version being incremented here (in
		// the entity service) vs. in the workflow layer. To keep things simple, I'm going
		// to decide that versioning (however light-weight and void of semantics) is a
		// responsibility of the model itself.
		config.version++;
		config.updatedAt = clock.utcNow();

		gateway.saveConfig( dataFilename, config );

	}

}
