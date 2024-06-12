component
	output = false
	hint = "I provide data serialization methods for the config entity."
	{

	// Define properties for dependency-injection.
	property name="validation" ioc:type="lib.model.config.ConfigValidation";

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I parse the given JSON payload and return the resultant config struct. No validation
	* is performed against the resultant structure; however, some config properties are
	* subsequently cast into the correct data types.
	*/
	public struct function deserializeConfig( required string input ) {

		try {

			var config = deserializeJson( input );

			// Date/time values don't serialize well. Convert them back into proper dates.
			config.createdAt = parseDateTime( config.createdAt );
			config.updatedAt = parseDateTime( config.updatedAt );

			return config;

		} catch ( any error ) {

			validation.throwDeserializationError( error );

		}

	}


	/**
	* I serialize the given config struct into a JSON string.
	*/
	public string function serializeConfig( required struct input ) {

		try {

			// Since we're about to change some internal properties, preparing them for
			// stringification, we need to detach the data from the calling context so
			// that we don't corrupt any possible references.
			var config = duplicate( input );

			// Date/time values don't serialize well. Let's convert them to ISO strings.
			config.createdAt = config.createdAt.dateTimeFormat( "iso" );
			config.updatedAt = config.updatedAt.dateTimeFormat( "iso" );

			return serializeJson( config );

		} catch ( any error ) {

			validation.throwSerializationError( error );

		}

	}

}
