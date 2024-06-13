component
	output = false
	hint = "I provide a simple cache that only stores a fixed number of elements. The data stored within the cache is duplicated upon both READ and WRITE in order to make sure that referential integrity is maintained."
	{

	/**
	* I initialize the cache with the given max size.
	*/
	public void function init( numeric maxSize = 20 ) {

		variables.data = [:];
		variables.maxSize = arguments.maxSize;
		variables.lockName = "FixedCacheMutation";
		variables.lockTimeout = 2;

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get a MAYBE result for the given key.
	*/
	public struct function maybeGet( required string key ) {

		lock
			type = "readonly"
			name = lockName
			timeout = lockTimeout
			{

			if ( data.keyExists( key ) ) {

				return {
					exists: true,
					value: duplicate( data[ key ] )
				};

			}

			return {
				exists: false
			};

		}

	}


	/**
	* I store the given value at the given key. The stored value is returned.
	*/
	public any function set(
		required string key,
		required any value
		) {

		lock
			type = "exclusive"
			name = lockName
			timeout = lockTimeout
			{

			data[ key ] = duplicate( value );

			var allKeys = data.keyArray();

			while ( allKeys.len() > maxSize ) {

				data.delete( allKeys.pop() );

			}

		}

		return value;

	}

}
