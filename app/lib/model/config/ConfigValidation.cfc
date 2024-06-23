component
	output = false
	hint = "I provide validation methods for the config entity."
	{

	// Define properties for dependency-injection.
	property name="environmentValidation" ioc:type="lib.demo.validation.EnvironmentValidation";
	property name="variantValidation" ioc:type="lib.demo.validation.VariantValidation";

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I validate and return the normalized config value.
	*/
	public struct function testConfig( required struct config ) {

		if ( ! config.keyExists( "environments" ) ) {

			throw( type = "App.Model.Config.Environments.Missing" );

		}

		if ( ! isStruct( config.environments ) ) {

			throw( type = "App.Model.Config.Environments.Invalid" );

		}

		var environments = environmentValidation.testEnvironments( config.environments );

		if ( ! config.keyExists( "features" ) ) {

			throw( type = "App.Model.Config.Features.Missing" );

		}

		if ( ! isStruct( config.features ) ) {

			throw( type = "App.Model.Config.Features.Invalid" );

		}

		var features = testFeatures( environments, config.features );

		return [
			environments: environments,
			features: features
		];

	}


	public struct function testEnvironment(
		required string key,
		required struct settings
		) {

		if ( ! key.len() ) {

			throw( type = "App.Model.Config.Environment.Key.Empty" );

		}

		if ( key.len() > 50 ) {

			throw( type = "App.Model.Config.Environment.Key.TooLong" );

		}

		if ( key.reFindNoCase( "[^a-z0-9_.-]" ) ) {

			throw( type = "App.Model.Config.Environment.Key.Invalid" );

		}

		var name = settings.keyExists( "name" )
			? settings.name
			: key
		;

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

		var description = settings.keyExists( "description" )
			? settings.description
			: ""
		;

		if ( ! isSimpleValue( description ) ) {

			throw( type = "App.Model.Config.Environment.Description.Invalid" );

		}

		description = toString( description ).trim();

		if ( description.len() > 255 ) {

			throw( type = "App.Model.Config.Environment.Description.TooLong" );

		}

		return [
			name: name,
			description: description
		];

	}


	public struct function testEnvironments( required struct environments ) {

		environments = environments.map(
			( key, value ) => {

				return testEnvironment( key, value );

			}
		);

		return environments;

	}


	public struct function testFeature(
		required struct allEnvironments,
		required string key,
		required struct settings
		) {

		if ( ! key.len() ) {

			throw( type = "App.Model.Config.Feature.Key.Empty" );

		}

		if ( key.len() > 50 ) {

			throw( type = "App.Model.Config.Feature.Key.TooLong" );

		}

		if ( key.reFindNoCase( "[^a-z0-9_.-]" ) ) {

			throw( type = "App.Model.Config.Feature.Key.Invalid" );

		}

		if ( ! settings.keyExists( "type" ) ) {

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
				var type = settings.type.lcase();
			break;
			default:
				throw( type = "App.Model.Config.Feature.Type.Invalid" );
			break;
		}

		var description = settings.keyExists( "description" )
			? settings.description
			: ""
		;

		if ( ! isSimpleValue( description ) ) {

			throw( type = "App.Model.Config.Feature.Description.Invalid" );

		}

		description = toString( description ).trim();

		if ( description.len() > 255 ) {

			throw( type = "App.Model.Config.Feature.Description.TooLong" );

		}

		if ( ! settings.keyExists( "variants" ) ) {

			throw( type = "App.Model.Config.Feature.Variants.Missing" );

		}

		if ( ! isArray( settings.variants ) ) {

			throw( type = "App.Model.Config.Feature.Variants.Invalid" );

		}

		if ( ! settings.variants.len() ) {

			throw( type = "App.Model.Config.Feature.Variants.Empty" );

		}

		var variants = settings.variants.map(
			( variantValue ) => {

				return testVariant( type, variantValue );

			}
		);

		var defaultSelection = settings.keyExists( "defaultSelection" )
			? settings.defaultSelection
			: 1
		;

		if ( ! isSimpleValue( defaultSelection ) ) {

			throw( type = "App.Model.Config.Feature.DefaultSelection.Invalid" );

		}

		defaultSelection = val( defaultSelection );

		if ( ! variants.isDefined( defaultSelection ) ) {

			throw( type = "App.Model.Config.Feature.DefaultSelection.OutOfBounds" );

		}

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


	public struct function testEnvironmentSetting(
		required struct accumulator,
		required string key,
		required struct settings
		) {

		if ( ! accumulator.environments.keyExists( key ) ) {

			throw( type = "App.Model.Config.Feature.Environment.Mismatch" );

		}

		var resolution = testResolution(variantType, variantValues, resolution)


		resolution: [
			type: "selection",
			selection: 1
		],
		rulesEnabled: false,
		rules: []


	}


	public struct function testEnvironmentSettings(
		required struct accumulator,
		required string key,
		required struct environments
		) {

		var result = environments.map(
			( key, value ) => {

				return testEnvironmentSetting( accumulator, key, value );

			}
		);

		return result;

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










	public struct function testResolution(
		required string variantType,
		required array variantValues,
		required struct resolution
		) {

		if ( ! resolution.keyExists( "type" ) ) {

			throw( type = "App.Model.Config.Resolution.Type.Missing" );

		}

		if ( ! isSimpleValue( resolution.type ) ) {

			throw( type = "App.Model.Config.Resolution.Type.Invalid" );

		}

		switch ( resolution.type ) {
			case "selection":

				return testResolutionAsSelection( variantValues, resolution );

			break;
			case "distribution":

				return testResolutionAsDistribution( variantType, variantValues, resolution );

			break;
			case "variant":

				return testResolutionAsVariant( variantType, resolution );

			break;
			default:

				throw( type = "App.Model.Config.Resolution.Type.NotSupported" );

			break;
		}

	}


	public struct function testResolutionAsDistribution(
		required string variantType,
		required array variantValues,
		required struct resolution
		) {

		if ( ! resolution.keyExists( "distribution" ) ) {

			throw( type = "App.Model.Config.Resolution.Distribution.Missing" );

		}

		if ( ! isArray( resolution.distribution ) ) {

			throw( type = "App.Model.Config.Resolution.Distribution.Invalid" );

		}

		if ( variantValues.len() != resolution.distribution.len() ) {

			throw( type = "App.Model.Config.Resolution.Distribution.Mismatch" );

		}

		var distribution = resolution.distribution.map(
			( value ) => {

				if ( ! isValid( "integer", value ) ) {

					throw( type = "App.Model.Config.Resolution.Distribution.InvalidAllocation" );

				}

				return val( value );

			}
		);

		if ( distribution.sum() != 100 ) {

			throw( type = "App.Model.Config.Resolution.Distribution.InvalidTotal" );

		}

		return [
			type: "distribution",
			distribution: distribution
		];

	}


	public struct function testResolutionAsSelection(
		required array variantValues,
		required struct resolution
		) {

		if ( ! resolution.keyExists( "selection" ) ) {

			throw( type = "App.Model.Config.Resolution.Selection.Missing" );

		}

		if ( ! isNumeric( resolution.selection ) ) {

			throw( type = "App.Model.Config.Resolution.Selection.Invalid" );

		}

		if ( ! variantValues.isDefined( resolution.selection ) ) {

			throw( type = "App.Model.Config.Resolution.Selection.OutOfBounds" );

		}

		return [
			type: "selection",
			selection: val( resolution.selection )
		];

	}


	public struct function testResolutionAsVariant(
		required string variantType,
		required struct resolution
		) {

		if ( ! resolution.keyExists( "variant" ) ) {

			throw( type = "App.Model.Config.Resolution.Variant.Missing" );

		}

		var variant = testVariant( variantType, resolution.variant );

		return [
			type: "variant",
			variant: variant
		];

	}


	public any function testVariant(
		required string variantType,
		required any variant
		) {

		switch ( variantType ) {
			case "boolean":
				return testVariantAsBoolean( variant );
			break;
			case "number":
				return testVariantAsNumber( variant );
			break;
			case "string":
				return testVariantAsString( variant );
			break;
			default:
				return testVariantAsAny( variant );
			break;
		}

	}


	public any function testVariantAsAny( required any variant ) {

		// For "any" variants, the only requirement is that they can be serialized.
		try {

			serializeJson( variant );

		} catch ( any error ) {

			throw( type = "App.Model.Config.Variant.Any.Invalid" );

		}

		return variant;

	}


	public boolean function testVariantAsBoolean( required any variant ) {

		if ( ! isBoolean( variant ) ) {

			throw( type = "App.Model.Config.Variant.Boolean.Invalid" );

		}

		return !! variant;

	}


	public numeric function testVariantAsNumber( required any variant ) {

		if ( ! isNumeric( variant ) ) {

			throw( type = "App.Model.Config.Variant.Number.Invalid" );

		}

		return val( variant );

	}


	public string function testVariantAsString( required any variant ) {

		if ( ! isSimpleValue( variant ) ) {

			throw( type = "App.Model.Config.Variant.String.Invalid" );

		}

		return toString( variant );

	}


	/**
	* I throw a version conflict error.
	*/
	public void function throwVersionConflictError() {

		throw(
			type = "App.Model.Config.Version.Conflict",
			message = "Submitted config data is expired."
		);

	}

}
