component
	output = false
	hint = "I provide a simple cache that only stores a fixed number of elements. The data stored within the cache is duplicated upon both READ and WRITE in order to make sure that referential integrity is maintained."
	{

	// Define properties for dependency-injection.
	property name="data" ioc:skip;
	property name="maxSize" ioc:skip;

	/**
	* I initialize the cache with the given max size.
	*/
	public void function init( numeric maxSize = 20 ) {

		variables.data = [:];
		variables.maxSize = arguments.maxSize;

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I delete the value cached at the given key.
	*/
	public void function delete( required string key ) {

		lock attributeCollection = synchronizedWrite() {

			data.delete( key );

		}

	}


	/**
	* I get a MAYBE result for the given key.
	*/
	public struct function maybeGet( required string key ) {

		lock attributeCollection = synchronizedRead() {

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

		lock attributeCollection = synchronizedWrite() {

			data[ key ] = duplicate( value );

			var allKeys = data.keyArray();

			while ( allKeys.len() > maxSize ) {

				data.delete( allKeys.pop() );

			}

		}

		return value;

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I get the attributes for the readonly lock.
	*/
	private struct function synchronizedRead( numeric timeoutInSeconds = 2 ) {

		return {
			name: "FixedCacheMutation",
			type: "readonly",
			timeout: timeoutInSeconds
		};

	}


	/**
	* I get the attributes for the exclusive lock.
	*/
	private struct function synchronizedWrite( numeric timeoutInSeconds = 2 ) {

		// The only difference between the READ and the WRITE lock is the [type]. As such,
		// we're going to use the read lock to define the base attributes and then simply
		// override the type. This way, the lock name is only defined in one place.
		return synchronizedRead( timeoutInSeconds ).append({
			type: "exclusive"
		});

	}

}
