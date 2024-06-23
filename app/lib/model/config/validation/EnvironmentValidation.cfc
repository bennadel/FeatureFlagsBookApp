component
	output = false
	hint = "I provide validation methods for the config environment."
	{

	// Define properties for dependency-injection.
	property name="validationUtilities" ioc:type="lib.ValidationUtilities";

	// ---
	// PUBLIC METHODS.
	// ---

	public struct function testEnvironment(
		required string key,
		required any settings
		) {

		key = testKey( key );
		settings = testSettings( key, settings );

		return settings;

	}


	public struct function testEnvironments( required struct environments ) {

		environments = environments.map(
			( key, value ) => {

				return testEnvironment( key, value );

			}
		);

		return environments;

	}

	// ---
	// PRIVATE METHODS.
	// ---

	private string function testDescription( required any description ) {

		if ( ! isSimpleValue( description ) ) {

			throw( type = "App.Model.Config.Environment.Description.Invalid" );

		}

		description = toString( description ).trim();

		if ( description.len() > 255 ) {

			throw( type = "App.Model.Config.Environment.Description.TooLong" );

		}

		if ( description != validationUtilities.canonicalizeInput( description ) ) {

			throw( type = "App.Model.Config.Environment.Description.SuspiciousEncoding" );

		}

		return description;

	}


	private string function testKey( required string key ) {

		if ( ! key.len() ) {

			throw( type = "App.Model.Config.Environment.Key.Empty" );

		}

		if ( key.len() > 50 ) {

			throw( type = "App.Model.Config.Environment.Key.TooLong" );

		}

		if ( key.reFindNoCase( "[^a-z0-9_.-]" ) ) {

			throw( type = "App.Model.Config.Environment.Key.Invalid" );

		}

		return key;

	}


	private string function testName(
		required string key,
		required any name
		) {

		if ( ! isSimpleValue( name ) ) {

			throw( type = "App.Model.Config.Environment.Name.Invalid" );

		}

		name = toString( settings.name ).trim();

		if ( ! name.len() ) {

			name = key;

		}

		if ( name.len() > 50 ) {

			throw( type = "App.Model.Config.Environment.Name.TooLong" );

		}

		if ( name != validationUtilities.canonicalizeInput( name ) ) {

			throw( type = "App.Model.Config.Environment.Name.SuspiciousEncoding" );

		}

		return name;

	}


	private struct function testSettings(
		required string key,
		required any settings
		) {

		if ( ! isStruct( settings ) ) {

			throw( type = "App.Model.Config.Environment.Invalid" );

		}

		var name = settings.keyExists( "name" )
			? settings.name
			: key
		;

		name = testName( name );

		var description = settings.keyExists( "description" )
			? settings.description
			: ""
		;

		description = testDescription( description );

		return [
			name: name,
			description: description
		];

	}

}
