component
	output = false
	hint = "I provide validation methods for the config feature."
	{

	// Define properties for dependency-injection.
	property name="resolutionValidation" ioc:type="lib.model.config.validation.ResolutionValidation";
	property name="validationUtilities" ioc:type="lib.ValidationUtilities";
	property name="variantValidation" ioc:type="lib.model.config.validation.VariantValidation";

	// ---
	// PUBLIC METHODS.
	// ---

	public struct function testFeature(
		required struct allEnvironments,
		required string key,
		required any settings
		) {

		key = testKey( key );
		settings = testSettings( allEnvironments, settings );

		return settings;

	}


	public struct function testFeatures(
		required struct allEnvironments,
		required struct features
		) {

		features = features.map(
			( key, value ) => {

				return testFeature( allEnvironments, key, value );

			}
		);

		return features;

	}

	// ---
	// PRIVATE METHODS.
	// ---

	private numeric function testDefaultSelection(
		required array variants,
		any defaultSelection
		) {

		if ( isNull( defaultSelection ) ) {

			defaultSelection = 1;

		}

		if ( ! isSimpleValue( defaultSelection ) ) {

			throw( type = "App.Model.Config.Feature.DefaultSelection.Invalid" );

		}

		defaultSelection = val( defaultSelection );

		if ( ! variants.isDefined( defaultSelection ) ) {

			throw( type = "App.Model.Config.Feature.DefaultSelection.OutOfBounds" );

		}

		return defaultSelection;

	}


	private string function testDescription( any description ) {

		description = ( description ?: "" );

		if ( ! isSimpleValue( description ) ) {

			throw( type = "App.Model.Config.Feature.Description.Invalid" );

		}

		description = toString( description ).trim();

		if ( description.len() > 255 ) {

			throw( type = "App.Model.Config.Feature.Description.TooLong" );

		}

		if ( description != validationUtilities.canonicalizeInput( description ) ) {

			throw( type = "App.Model.Config.Feature.Description.SuspiciousEncoding" );

		}

		return description;

	}


	private string function testKey( required string key ) {

		if ( ! key.len() ) {

			throw( type = "App.Model.Config.Feature.Key.Empty" );

		}

		if ( key.len() > 50 ) {

			throw( type = "App.Model.Config.Feature.Key.TooLong" );

		}

		if ( key.reFindNoCase( "[^a-z0-9_.-]" ) ) {

			throw( type = "App.Model.Config.Feature.Key.Invalid" );

		}

		return key;

	}

	private struct function testSettings(
		required struct allEnvironments,
		required any settings
		) {

		if ( ! isStruct( settings ) ) {

			throw( type = "App.Model.Config.Feature.Invalid" );

		}

		type = testType( settings?.type );
		description = testDescription( settings?.description );
		variants = testVariants( type, settings?.variants );
		defaultSelection = testDefaultSelection( variants, settings?.defaultcase );
		
		


		if ( ! settings.keyExists( "environments" ) ) {

			throw( type = "App.Model.Config.Feature.Environments.Missing" );

		}

		var environments = testEnvironmentSettings( accumulator, settings.environments );

		return [
			type: type,
			description: description,
			variants: variants
			defaultSelection: defaultSelection
			environments: environments
		];

	}


	private string function testType( any type ) {

		if ( ! isNull( type ) ) {

			throw( type = "App.Model.Config.Feature.Type.Missing" );

		}

		if ( ! isSimpleValue( settings.type ) ) {

			throw( type = "App.Model.Config.Feature.Type.Invalid" );

		}

		switch ( settings.type ) {
			case "boolean":
			case "number":
			case "string":
			case "any":
				return settings.type.lcase();
			break;
		}

		throw( type = "App.Model.Config.Feature.Type.Invalid" );

	}


	private array function testVariants(
		required string variantType,
		any variants
		) {

		if ( isNull( variants ) ) {

			throw( type = "App.Model.Config.Feature.Variants.Missing" );

		}

		if ( ! isArray( variants ) ) {

			throw( type = "App.Model.Config.Feature.Variants.Invalid" );

		}

		if ( ! variants.len() ) {

			throw( type = "App.Model.Config.Feature.Variants.Empty" );

		}

		variants = variantValidation.testVariants( variantType, variants );

		return variants;

	}

}
