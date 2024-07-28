component
	output = false
	hint = "I provide data gateway methods for the config entity."
	{

	// Define properties for dependency-injection.
	property name="serializer" ioc:type="lib.model.config.ConfigSerializer";

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I initialize the gateway.
	*/
	public void function init() {

		// Since checking for physical JSON data files is relatively slow, I'm going to
		// keep a limited set of data cached in memory. Since this app won't have a
		// traffic, the churn of data won't be an issue.
		// --
		// Note: The cache duplicates the value on both SET and GET.
		variables.cache = new FixedCache( 30 );

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I delete the config data stored at the given filename. If there is no persisted
	* data, this is a no-op.
	*/
	public void function deleteConfig( required string dataFilename ) {

		cache.delete( dataFilename );

		var dataFilepath = getDataFilepath( dataFilename );

		if ( fileExists( dataFilepath ) ) {

			fileDelete( dataFilepath );

		}

	}


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

		var config = serializer.deserializeConfig( fileRead( dataFilepath, "utf-8" ) );

		return cache.set( dataFilename, config );

	}


	/**
	* I save the given config data to the given filename.
	*/
	public void function saveConfig(
		required string dataFilename,
		required struct config
		) {

		config = cache.set( dataFilename, config );

		fileWrite( getDataFilepath( dataFilename ), serializer.serializeConfig( config ) );

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
