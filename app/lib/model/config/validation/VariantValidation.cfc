component
	output = false
	hint = "I provide validation methods for the config variant."
	{

	public any function testVariant(
		required string variantType,
		required any variant
		) {

		switch ( variantType ) {
			case "boolean":
				return testAsBoolean( variant );
			break;
			case "number":
				return testAsNumber( variant );
			break;
			case "string":
				return testAsString( variant );
			break;
			default:
				return testAsAny( variant );
			break;
		}

	}

	public array function testVariants(
		required string variantType,
		required array variants
		) {

		variants = variants.map(
			( variant ) => {

				return testVariant( variantType, variant );

			}
		);

		return variants;

	}

	// ---
	// PRIVATE METHODS.
	// ---

	private any function testAsAny( required any variant ) {

		// For "any" variants, the only requirement is that they can be serialized.
		try {

			serializeJson( variant );

		} catch ( any error ) {

			throw( type = "App.Model.Config.Variant.Any.Invalid" );

		}

		return variant;

	}


	private boolean function testAsBoolean( required any variant ) {

		if ( ! isBoolean( variant ) ) {

			throw( type = "App.Model.Config.Variant.Boolean.Invalid" );

		}

		return !! variant;

	}


	private numeric function testAsNumber( required any variant ) {

		if ( ! isNumeric( variant ) ) {

			throw( type = "App.Model.Config.Variant.Number.Invalid" );

		}

		return val( variant );

	}


	private string function testAsString( required any variant ) {

		if ( ! isSimpleValue( variant ) ) {

			throw( type = "App.Model.Config.Variant.String.Invalid" );

		}

		return toString( variant );

	}

}
