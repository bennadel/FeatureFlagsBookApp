component
	output = false
	hint = "I provide validation methods for the config resolution."
	{

	// Define properties for dependency-injection.
	property name="variantValidation" ioc:type="lib.model.config.validation.VariantValidation";

	// ---
	// PUBLIC METHODS.
	// ---

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

				return testAsSelection( variantValues, resolution );

			break;
			case "distribution":

				return testAsDistribution( variantType, variantValues, resolution );

			break;
			case "variant":

				return testAsVariant( variantType, resolution );

			break;
			default:

				throw( type = "App.Model.Config.Resolution.Type.NotSupported" );

			break;
		}

	}

	// ---
	// PRIVATE METHODS.
	// ---

	private struct function testAsDistribution(
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


	private struct function testAsSelection(
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


	private struct function testAsVariant(
		required string variantType,
		required struct resolution
		) {

		if ( ! resolution.keyExists( "variant" ) ) {

			throw( type = "App.Model.Config.Resolution.Variant.Missing" );

		}

		var variant = variantValidation.testVariant( variantType, resolution.variant );

		return [
			type: "variant",
			variant: variant
		];

	}

}
