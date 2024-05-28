component
	output = false
	hint = "I provide data gateway methods for the config entity."
	{

	/**
	* I get the config data stored at the given filename. If there is no persisted data,
	* an empty structure is returned.
	*/
	public struct function getConfig( required string dataFilename ) {

		var dataFilepath = getDataFilepath( dataFilename );

		if ( ! fileExists( dataFilepath ) ) {

			return [:];

		}

		var result = deserializeJson( fileRead( dataFilepath, "utf-8" ) );

		// Date/time values don't serialize well. Convert them back into proper dates.
		result.createdAt = parseDateTime( result.createdAt );
		result.updatedAt = parseDateTime( result.updatedAt );

		return result;

	}


	/**
	* I save the given config data to the given filename.
	*/
	public void function saveConfig(
		required string dataFilename,
		required struct config
		) {

		// Caution: We're assuming that the config object reference has already been
		// isolated from any calling context and is safe to mutate prior to serialization.
		// Date/time values don't serialize well. Let's convert them to ISO strings.
		config.createdAt = config.createdAt.dateTimeFormat( "iso" );
		config.updatedAt = config.updatedAt.dateTimeFormat( "iso" );

		fileWrite( getDataFilepath( dataFilename ), serializeJson( config ) );

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I return the fully qualified path to the given data file.
	*/
	private string function getDataFilepath( required string dataFilename ) {

		return expandPath( "/data/#dataFilename#" );

	}

}
