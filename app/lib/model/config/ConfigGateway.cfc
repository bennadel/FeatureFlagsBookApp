component
	output = false
	hint = "I provide data gateway methods for the config entity."
	{

	/**
	* I initialize the gateway.
	*/
	public void function init() {

		// Since checking for physical JSON data files is relatively slow, I'm going to
		// keep a limited set of data cached in memory. Since this app won't have a
		// traffic, the churn of data won't be an issue.
		variables.cache = new FixedCache( 30 );

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get the config data stored at the given filename. If there is no persisted data,
	* an empty structure is returned.
	*/
	public struct function getConfig( required string dataFilename ) {

		var maybeCached = cache.maybeGet( dataFilename );

		if ( maybeCached.exists ) {

			return maybeCached.value;

		}

		var dataFilepath = getDataFilepath( dataFilename );

		if ( ! fileExists( dataFilepath ) ) {

			return cache.set( dataFilename, [:] );

		}

		var result = deserializeJson( fileRead( dataFilepath, "utf-8" ) );

		// Date/time values don't serialize well. Convert them back into proper dates.
		result.createdAt = parseDateTime( result.createdAt );
		result.updatedAt = parseDateTime( result.updatedAt );

		return cache.set( dataFilename, result );

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
		config = cache.set( dataFilename, duplicate( config ) );

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
