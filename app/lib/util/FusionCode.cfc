component
	output = false
	hint = "I provide methods for generating a consistent, repeatable token for a given ColdFusion data structure (akin to Java's hashCode, but with configurable ColdFusion looseness)."
	{

	/**
	* I initialize the component with the given default settings.
	*/
	public void function init(
		boolean caseSensitiveKeys = true,
		boolean typeCoercion = false
		) {

		variables.defaultOptions = {
			// I determine if struct keys should be normalized during hashing. Meaning,
			// should the key `"name"` and the key `"NAME"` be canonicalized as the same
			// key? Or, should they be considered two different keys?
			caseSensitiveKeys: caseSensitiveKeys,
			// I determine if type-coercion should be allowed during hashing. Meaning,
			// should the boolean `true` and the string `"true"` be canonicalized as the
			// same input? Or, should all values be kept in their provided types? This
			// setting DOES NOT apply to low-level Java data types that fall under the
			// same ColdFusion umbrella. Meaning, a Java "int" and a Java "long" are both
			// still native "numeric" values in ColdFusion. As such, they will be
			// canonicalized as the same value during hashing.
			typeCoercion: typeCoercion
		};

		variables.Double = createObject( "java", "java.lang.Double" );

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I determine if the two values are equal based on their generated FusionCodes.
	*/
	public boolean function deepEquals(
		any valueA,
		any valueB,
		struct options = defaultOptions
		) {

		var codeA = getFusionCode( arguments?.valueA, options );
		var codeB = getFusionCode( arguments?.valueB, options );

		return ( codeA == codeB );

	}


	/**
	* I calculate the FusionCode for the given value.
	*
	* The FusionCode algorithm creates a CRC-32 checksum and then traverses the given data
	* structure and adds each visited value to the checksum calculation. Since ColdFusion
	* is a loosely typed / dynamically typed language, the FusionCode algorithm has to
	* make some judgement calls. For example, since the Java int `3` and the Java long `3`
	* are both native "numeric" types in ColdFusion, they will both be canonicalized as
	* the the same value. However, when it comes to different native ColdFusion types,
	* such as the Boolean value `true` and the quasi-equivalent string value `"YES"`, type
	* coercion will be based on the passed-in options; and, on the order in which types
	* are checked during the traversal.
	*/
	public numeric function getFusionCode(
		any value,
		struct options = defaultOptions
		) {

		var checksum = createObject( "java", "java.util.zip.CRC32" ).init();

		visitValue( coalesceOptions( options ), checksum, arguments?.value );

		return checksum.getValue();

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I merge the given options and the default options. The given options takes a higher
	* precedence, overwriting any default options.
	*/
	private struct function coalesceOptions( required struct options ) {

		return defaultOptions.copy().append( options );

	}


	/**
	* I determine if the given value is one of Java's special number types.
	*/
	private boolean function isComplexNumber( required any value ) {

		return (
			isInstanceOf( value, "java.math.BigDecimal" ) ||
			isInstanceOf( value, "java.math.BigInteger" )
		);

	}


	/**
	* I determine if the given value is strictly a Boolean.
	*/
	private boolean function isStrictBoolean( required any value ) {

		return (
			isInstanceOf( value, "java.lang.Boolean" ) ||
			// Fall-back checks for legacy ColdFusion types.
			isInstanceOf( value, "coldfusion.runtime.CFBoolean" )
		);

	}


	/**
	* I determine if the given value is strictly a Date.
	*/
	private boolean function isStrictDate( required any value ) {

		return (
			isInstanceOf( value, "java.util.Date" ) ||
			// Fall-back checks for legacy ColdFusion types.
			isInstanceOf( value, "coldfusion.runtime.OleDateTime" )
		);

	}


	/**
	* I determine if the given value is strictly a numeric type.
	*/
	private boolean function isStrictNumeric( required any value ) {

		// Number is the base class for (among others):
		//
		// - java.lang.Double
		// - java.lang.Float
		// - java.lang.Integer
		// - java.lang.Long
		// - java.lang.Short
		//
		// But, it's unclear as to whether or not it covers all of the custom ColdFusion
		// data types, like "CFDouble". As such, I'm including those here as well.
		return (
			isInstanceOf( value, "java.lang.Number" ) ||
			// Fall-back checks for legacy ColdFusion types.
			isInstanceOf( value, "coldfusion.runtime.CFDouble" ) ||
			isInstanceOf( value, "coldfusion.runtime.CFFloat" ) ||
			isInstanceOf( value, "coldfusion.runtime.CFInteger" ) ||
			isInstanceOf( value, "coldfusion.runtime.CFLong" ) ||
			isInstanceOf( value, "coldfusion.runtime.CFShort" )
		);

	}


	/**
	* I obfuscate the given stringified value so that it doesn't accidentally collide with
	* a string literal. When the visited values are canonicalized, they are often
	* converted to STRING values; and, I need to make sure that the stringified version of
	* a value doesn't match a native string value that might be present in the user-
	* provided data structure.
	*/
	private string function obfuscate( required string value ) {

		return "[[______#value#______]]";

	}


	/**
	* I add the given Boolean value to the checksum.
	*/
	private void function putBoolean(
		required any checksum,
		required boolean value
		) {

		putString( checksum, obfuscate( value ? "true" : "false" ) );

	}


	/**
	* I add the given date value to the checksum.
	*/
	private void function putDate(
		required any checksum,
		required date value
		) {

		putString( checksum, obfuscate( dateTimeFormat( value, "iso" ) ) );

	}


	/**
	* I add the given number value to the checksum.
	*/
	private void function putNumber(
		required any checksum,
		required numeric value
		) {

		putString(
			checksum,
			obfuscate( Double.toString( javaCast( "double", value ) ) )
		);

	}


	/**
	* I add the given string value to the checksum.
	*/
	private void function putString(
		required any checksum,
		required string value
		) {

		checksum.update( charsetDecode( value, "utf-8" ) );

	}


	/**
	* I visit the given array value, recursively visiting each element.
	*/
	private void function visitArray(
		required struct options,
		required any checksum,
		required array value
		) {

		var length = arrayLen( value );

		for ( var i = 1 ; i <= length ; i++ ) {

			putNumber( checksum, i );

			if ( arrayIsDefined( value, i ) ) {

				visitValue( options, checksum, value[ i ] );

			} else {

				visitValue( options, checksum /* , NULL */ );

			}

		}

	}


	/**
	* I visit the given binary value.
	*/
	private void function visitBinary(
		required struct options,
		required any checksum,
		required binary value
		) {

		checksum.update( value );

	}


	/**
	* I visit the given complex number.
	*/
	private void function visitComplexNumber(
		required struct options,
		required any checksum,
		required any value
		) {

		// ColdFusion seems to sometimes parse numeric literals into BigInteger and
		// BigDecimal. Let's convert both of those to DOUBLE. I think that there's a
		// chance that some value truncation may occur here; but, I think it may be edge-
		// case enough to not worry about it.
		putNumber( checksum, value.doubleValue() );

	}


	/**
	* I visit the given Java value.
	*/
	private void function visitJava(
		required struct options,
		required any checksum,
		required any value
		) {

		putNumber( checksum, value.hashCode() );

	}


	/**
	* I visit the given null value.
	*/
	private void function visitNull(
		required struct options,
		required any checksum
		) {

		putString( checksum, obfuscate( "null" ) );

	}


	/**
	* I visit the given query value, recursively visiting each row.
	*/
	private void function visitQuery(
		required struct options,
		required any checksum,
		required query value
		) {

		var columnNames = value.columnList
			.listToArray()
			.sort( "textnocase" )
			.toList( "," )
		;

		if ( options.caseSensitiveKeys ) {

			putString( checksum, columnNames );

		} else {

			putString( checksum, ucase( columnNames ) );

		}

		for ( var i = 1 ; i <= value.recordCount ; i++ ) {

			putNumber( checksum, i );
			visitStruct( options, checksum, queryGetRow( value, i ) );

		}

	}


	/**
	* I visit the given simple value.
	*/
	private void function visitSimpleValue(
		required struct options,
		required any checksum,
		required any value
		) {

		// When it comes to coercing types in ColdFusion, there's no perfect approach. We
		// might come out with a different result depending on the order in which we check
		// the types. For example, the value "1" is both a Numeric type and a Boolean
		// type. And the value "2023-03-03" is both a String type and Date type. These
		// values will be hashed differently depending on which type we check first. As
		// such, I just had to make a decision and try to be consistent. This is certainly
		// not a perfect algorithm.
		if ( options.typeCoercion ) {

			if ( isNumeric( value ) ) {

				putNumber( checksum, value );

			} else if ( isDate( value ) ) {

				putDate( checksum, value );

			} else if ( isBoolean( value ) ) {

				putBoolean( checksum, value );

			} else {

				putString( checksum, value );

			}

		// No type-coercion - strict matches only.
		} else {

			if ( isStrictNumeric( value ) ) {

				putNumber( checksum, value );

			} else if ( isStrictDate( value ) ) {

				putDate( checksum, value );

			} else if ( isStrictBoolean( value ) ) {

				putBoolean( checksum, value );

			} else {

				putString( checksum, value );

			}

		}

	}


	/**
	* I visit the given struct value, recursively visiting each entry.
	*/
	private void function visitStruct(
		required struct options,
		required any checksum,
		required struct value
		) {

		var keys = structKeyArray( value )
			.sort( "textnocase" )
		;

		for ( var key in keys ) {

			if ( options.caseSensitiveKeys ) {

				putString( checksum, key );

			} else {

				putString( checksum, ucase( key ) );

			}

			if ( structKeyExists( value, key ) ) {

				visitValue( options, checksum, value[ key ] );

			} else {

				visitValue( options, checksum /* , NULL */ );

			}

		}

	}


	/**
	* I visit the given xml value.
	*/
	private void function visitXml(
		required struct options,
		required any checksum,
		required xml value
		) {

		// Note: I'm just punting on the case-sensitivity here since I don't use XML. Does
		// anyone use XML anymore?
		putString( checksum, obfuscate( toString( value ) ) );

	}


	/**
	* I visit the given generic value, routing the value to a more specific visit method.
	*
	* Note: This method doesn't check for values that wouldn't otherwise be in basic data
	* structure. For example, I'm not checking for things like Closures or CFC instances.
	* This is intended to be used with serializable data.
	*/
	private void function visitValue(
		required struct options,
		required any checksum,
		any value
		) {

		if ( isNull( value ) ) {

			visitNull( options, checksum );

		} else if ( isArray( value ) ) {

			visitArray( options, checksum, value );

		} else if ( isStruct( value ) ) {

			visitStruct( options, checksum, value );

		} else if ( isQuery( value ) ) {

			visitQuery( options, checksum, value );

		} else if ( isXmlDoc( value ) ) {

			visitXml( options, checksum, value );

		} else if ( isBinary( value ) ) {

			visitBinary( options, checksum, value );

		} else if ( isComplexNumber( value ) ) {

			visitComplexNumber( options, checksum, value );

		} else if ( isSimpleValue( value ) ) {

			visitSimpleValue( options, checksum, value );

		} else {

			visitJava( options, checksum, value );

		}

	}

}
