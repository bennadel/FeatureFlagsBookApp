component
	output = false
	hint = "I help convert user keys (strings) into distribution indexes (1...100)."
	{

	/**
	* I initialize the converter.
	*/
	public void function init() {

		variables.BigIntegerClass = createObject( "java", "java.math.BigInteger" );

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I convert the given string-based key into a 1...100 bucket index.
	*/
	public numeric function toIndex( required string contextKey ) {

		var checksum = createObject( "java", "java.util.zip.CRC32" )
			.init()
		;
		checksum.update( charsetDecode( contextKey, "utf-8" ) );

		var bigKey = BigIntegerClass.valueOf( checksum.getValue() );
		var bigBucketCount = BigIntegerClass.valueOf( 100 );

		return ( bigKey.mod( bigBucketCount ) + 1 );

	}

}
