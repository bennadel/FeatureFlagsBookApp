component
	output = false
	hint = "I provide validation methods for the config entity."
	{

	// Define properties for dependency-injection.
	property name="clock" ioc:type="lib.util.Clock";
	property name="validationUtilities" ioc:type="lib.util.ValidationUtilities";

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I validate and return the normalized config value. This performs a DEEP COPY of the
	* given value and ensures that all the proper type-casing and key-casing is used.
	*/
	public struct function testConfig( any config ) {

		var validationPath = "config";

		if ( isNull( config ) ) {

			throw(
				type = "App.Model.Config.Missing",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		if ( ! isStruct( config ) ) {

			throw(
				type = "App.Model.Config.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		var email = testConfigEmail(
			validationPath = "#validationPath#.email",
			email = config?.email
		);
		var version = testConfigVersion(
			validationPath = "#validationPath#.version",
			version = config?.version
		);
		var createdAt = testConfigCreatedAt(
			validationPath = "#validationPath#.createdAt",
			createdAt = config?.createdAt
		);
		var updatedAt = testConfigUpdatedAt(
			validationPath = "#validationPath#.updatedAt",
			createdAt = createdAt,
			updatedAt = config?.updatedAt
		);
		var environments = testConfigEnvironments(
			validationPath = "#validationPath#.environments",
			environments = config?.environments
		);
		var features = testConfigFeatures(
			validationPath = "#validationPath#.features",
			environments = environments,
			features = config?.features
		);

		return [
			email: email,
			version: version,
			createdAt: createdAt,
			updatedAt: updatedAt,
			environments: environments,
			features: features
		];

	}


	/**
	* I throw a deserialization error for the config data.
	*/
	public void function throwDeserializationError( required any rootCause ) {

		throw(
			type = "App.Model.Config.DeserializationFailure",
			extendedInfo = validationUtilities.serializeRootCauseError( rootCause )
		);

	}


	/**
	* I throw an email conflict error.
	*/
	public void function throwEmailConflictError() {

		throw( type = "App.Model.Config.Email.Conflict" );

	}


	/**
	* I throw a feature not found error.
	*/
	public void function throwFeatureNotFoundError() {

		throw( type = "App.Model.Config.Feature.NotFound" );

	}


	/**
	* I throw a serialization error for the config data.
	*/
	public void function throwSerializationError( required any rootCause ) {

		throw(
			type = "App.Model.Config.SerializationFailure",
			extendedInfo = validationUtilities.serializeRootCauseError( rootCause )
		);

	}


	/**
	* I throw an version conflict error.
	*/
	public void function throwVersionConflictError() {

		throw( type = "App.Model.Config.Version.Conflict" );

	}

	// ---
	// PRIVATE CONFIG METHODS.
	// ---

	/**
	* I test the top-level created at.
	*/
	private date function testConfigCreatedAt(
		required string validationPath,
		any createdAt = clock.utcNow()
		) {

		if ( ! isDate( createdAt ) ) {

			throw(
				type = "App.Model.Config.CreatedAt.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		createdAt = dateAdd( "d", 0, createdAt );

		return createdAt;

	}


	/**
	* I test the top-level email.
	*/
	private string function testConfigEmail(
		required string validationPath,
		any email = ""
		) {

		if ( ! isSimpleValue( email ) ) {

			throw(
				type = "App.Model.Config.Email.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		email = toString( email ).lcase().trim();

		if ( ! email.len() ) {

			throw(
				type = "App.Model.Config.Email.Empty",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		return email;

	}


	/**
	* I test the top-level environments.
	*/
	private struct function testConfigEnvironments(
		required string validationPath,
		any environments = [:]
		) {

		if ( ! isStruct( environments ) ) {

			throw(
				type = "App.Model.Config.Environments.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		environments = environments.map(
			( key, value ) => {

				return testEnvironment(
					validationPath = "#validationPath#.#key#",
					key = key,
					settings = arguments?.value
				);

			}
		);

		return environments;

	}


	/**
	* I test the top-level features.
	*/
	private struct function testConfigFeatures(
		required string validationPath,
		required struct environments,
		any features = [:]
		) {

		if ( ! isStruct( features ) ) {

			throw(
				type = "App.Model.Config.Features.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		features = features.map(
			( key, value ) => {

				return testFeature(
					validationPath = "#validationPath#.#key#",
					environments = environments,
					key = key,
					settings = arguments?.value
				);

			}
		);

		return features;

	}


	/**
	* I test the top-level updated at.
	*/
	private date function testConfigUpdatedAt(
		required string validationPath,
		required date createdAt,
		any updatedAt = clock.utcNow()
		) {

		if ( ! isDate( updatedAt ) ) {

			throw(
				type = "App.Model.Config.UpdatedAt.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		if ( updatedAt < createdAt ) {

			throw(
				type = "App.Model.Config.UpdatedAt.OutOfBounds",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		updatedAt = dateAdd( "d", 0, updatedAt );

		return updatedAt;

	}


	/**
	* I test the top-level version.
	*/
	private numeric function testConfigVersion(
		required string validationPath,
		any version = 1
		) {

		if ( ! isValid( "integer", version ) ) {

			throw(
				type = "App.Model.Config.Version.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		return val( version );

	}

	// ----
	// PRIVATE ENVIRONMENT METHODS.
	// ----

	/**
	* I test the given environment settings.
	*/
	private struct function testEnvironment(
		required string validationPath,
		required string key,
		any settings
		) {

		key = testEnvironmentKey(
			validationPath = "#validationPath#.key",
			key = key
		);

		if ( isNull( settings ) ) {

			throw(
				type = "App.Model.Config.Environment.Missing",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		if ( ! isStruct( settings ) ) {

			throw(
				type = "App.Model.Config.Environment.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		var name = testEnvironmentName(
			validationPath = "#validationPath#.name",
			key = key,
			name = ( settings.name ?: key )
		);
		var description = testEnvironmentDescription(
			validationPath = "#validationPath#.description",
			description = ( settings.description ?: "" )
		);

		return [
			name: name,
			description: description
		];

	}


	/**
	* I test the given environment description.
	*/
	private string function testEnvironmentDescription(
		required string validationPath,
		required any description
		) {

		if ( ! isSimpleValue( description ) ) {

			throw(
				type = "App.Model.Config.Environment.Description.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		description = toString( description ).trim();

		if ( description.len() > 255 ) {

			throw(
				type = "App.Model.Config.Environment.Description.TooLong",
				extendedInfo = serializeJson({
					validationPath: validationPath,
					maxLength: 255
				})
			);

		}

		if ( description != validationUtilities.canonicalizeInput( description ) ) {

			throw(
				type = "App.Model.Config.Environment.Description.SuspiciousEncoding",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		return description;

	}


	/**
	* I test the given environment key.
	*/
	private string function testEnvironmentKey(
		required string validationPath,
		required string key
		) {

		if ( ! key.len() ) {

			throw(
				type = "App.Model.Config.Environment.Key.Empty",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		if ( key.len() > 50 ) {

			throw(
				type = "App.Model.Config.Environment.Key.TooLong",
				extendedInfo = serializeJson({
					validationPath: validationPath,
					maxLength: 50
				})
			);

		}

		if ( key.reFindNoCase( "[^a-z0-9_-]" ) ) {

			throw(
				type = "App.Model.Config.Environment.Key.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		return key;

	}


	/**
	* I test the given environment name.
	*/
	private string function testEnvironmentName(
		required string validationPath,
		required string key,
		required any name
		) {

		if ( ! isSimpleValue( name ) ) {

			throw(
				type = "App.Model.Config.Environment.Name.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		name = toString( name ).trim();

		if ( ! name.len() ) {

			name = key;

		}

		if ( name.len() > 50 ) {

			throw(
				type = "App.Model.Config.Environment.Name.TooLong",
				extendedInfo = serializeJson({
					validationPath: validationPath,
					maxLength: 50
				})
			);

		}

		if ( name != validationUtilities.canonicalizeInput( name ) ) {

			throw(
				type = "App.Model.Config.Environment.Name.SuspiciousEncoding",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		return name;

	}

	// ----
	// PRIVATE FEATURE METHODS.
	// ----

	/**
	* I test the given feature settings.
	*/
	private struct function testFeature(
		required string validationPath,
		required struct environments,
		required string key,
		any settings
		) {

		key = testFeatureKey(
			validationPath = "#validationPath#.key",
			key = key
		);

		if ( isNull( settings ) ) {

			throw(
				type = "App.Model.Config.Feature.Missing",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		if ( ! isStruct( settings ) ) {

			throw(
				type = "App.Model.Config.Feature.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		var type = testFeatureType(
			validationPath = "#validationPath#.type",
			type = settings?.type
		);
		var description = testFeatureDescription(
			validationPath = "#validationPath#.description",
			description = settings?.description
		);
		var variants = testFeatureVariants(
			validationPath = "#validationPath#.variants",
			feature = [
				type: type
			],
			variants = settings?.variants
		);
		var defaultSelection = testFeatureDefaultSelection(
			validationPath = "#validationPath#.defaultSelection",
			feature = [
				type: type,
				variants: variants
			],
			defaultSelection = settings?.defaultSelection
		);

		var targeting = testFeatureTargeting(
			validationPath = "#validationPath#.targeting",
			environments = environments,
			feature = [
				type: type,
				variants: variants
			],
			settings = settings?.targeting
		);

		return [
			type: type,
			description: description,
			variants: variants,
			defaultSelection: defaultSelection,
			targeting: targeting
		];

	}


	/**
	* I test the given feature default selection.
	*/
	private numeric function testFeatureDefaultSelection(
		required string validationPath,
		required struct feature,
		any defaultSelection = 1
		) {

		if ( ! isValid( "integer", defaultSelection ) ) {

			throw(
				type = "App.Model.Config.Feature.DefaultSelection.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath,
					variantCount: feature.variants.len()
				})
			);

		}

		defaultSelection = val( defaultSelection );

		if ( ! feature.variants.isDefined( defaultSelection ) ) {

			throw(
				type = "App.Model.Config.Feature.DefaultSelection.OutOfBounds",
				extendedInfo = serializeJson({
					validationPath: validationPath,
					variantCount: feature.variants.len()
				})
			);

		}

		return defaultSelection;

	}


	/**
	* I test the given feature description.
	*/
	private string function testFeatureDescription(
		required string validationPath,
		any description = ""
		) {

		if ( ! isSimpleValue( description ) ) {

			throw(
				type = "App.Model.Config.Feature.Description.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		description = toString( description ).trim();

		if ( description.len() > 255 ) {

			throw(
				type = "App.Model.Config.Feature.Description.TooLong",
				extendedInfo = serializeJson({
					validationPath: validationPath,
					maxLength: 255
				})
			);

		}

		if ( description != validationUtilities.canonicalizeInput( description ) ) {

			throw(
				type = "App.Model.Config.Feature.Description.SuspiciousEncoding",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		return description;

	}


	/**
	* I test the given feature key.
	*/
	private string function testFeatureKey(
		required string validationPath,
		required string key
		) {

		if ( ! key.len() ) {

			throw(
				type = "App.Model.Config.Feature.Key.Empty",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		if ( key.len() > 50 ) {

			throw(
				type = "App.Model.Config.Feature.Key.TooLong",
				extendedInfo = serializeJson({
					validationPath: validationPath,
					maxLength: 50
				})
			);

		}

		if ( key.reFindNoCase( "[^a-z0-9_-]" ) ) {

			throw(
				type = "App.Model.Config.Feature.Key.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		return key;

	}


	/**
	* I test the given feature targeting.
	*/
	private struct function testFeatureTargeting(
		required string validationPath,
		required struct environments,
		required struct feature,
		any settings
		) {

		if ( isNull( settings ) ) {

			throw(
				type = "App.Model.Config.Feature.Targeting.Missing",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		if ( ! isStruct( settings ) ) {

			throw(
				type = "App.Model.Config.Feature.Targeting.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		// First, we need to make sure that every environment in the configuration is also
		// represented in this collection of targeting contexts.
		// --
		// Note: Using .map() instead of .each() because there's a ColdFusion bug in which
		// errors aren't properly surfaced within a .each().
		environments.map(
			( key ) => {

				if ( ! settings.keyExists( key ) ) {

					throw(
						type = "App.Model.Config.Feature.Targeting.Entry.Missing",
						extendedInfo = serializeJson({
							validationPath: "#validationPath#.#key#"
						})
					);

				}

			}
		);

		// Second, we need to make sure that all of the targeting contexts in this feature
		// are represented in the collection of configuration environments.
		// --
		// Note: Using .map() instead of .each() because there's a ColdFusion bug in which
		// errors aren't properly surfaced within a .each().
		settings.map(
			( key ) => {

				if ( ! environments.keyExists( key ) ) {

					throw(
						type = "App.Model.Config.Feature.Targeting.Entry.OutOfBounds",
						extendedInfo = serializeJson({
							validationPath: "#validationPath#.#key#"
						})
					);

				}

			}
		);

		settings = settings.map(
			( key, value ) => {

				return testTargeting(
					validationPath = "#validationPath#.#key#",
					feature = feature,
					settings = arguments?.value
				);

			}
		);

		return settings;

	}


	/**
	* I test the given feature type.
	*/
	private string function testFeatureType(
		required string validationPath,
		any type
		) {

		if ( isNull( type ) ) {

			throw(
				type = "App.Model.Config.Feature.Type.Missing",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		if ( ! isSimpleValue( type ) ) {

			throw(
				type = "App.Model.Config.Feature.Type.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		var knownTypes = [
			"boolean",
			"number",
			"string",
			"any"
		];

		for ( var knownType in knownTypes ) {

			if ( knownType == type ) {

				return knownType;

			}

		}

		throw(
			type = "App.Model.Config.Feature.Type.Unsupported",
			extendedInfo = serializeJson({
				validationPath: validationPath,
				typeList: knownTypes.toList( ", " )
			})
		);

	}


	/**
	* I test the given feature variants.
	*/
	private array function testFeatureVariants(
		required string validationPath,
		required struct feature,
		any variants
		) {

		if ( isNull( variants ) ) {

			throw(
				type = "App.Model.Config.Feature.Variants.Missing",
				extendedInfo = serializeJson({
					validationPath: validationPath,
					featureType: feature.type
				})
			);

		}

		if ( ! isArray( variants ) ) {

			throw(
				type = "App.Model.Config.Feature.Variants.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath,
					featureType: feature.type
				})
			);

		}

		if ( ! variants.len() ) {

			throw(
				type = "App.Model.Config.Feature.Variants.Empty",
				extendedInfo = serializeJson({
					validationPath: validationPath,
					featureType: feature.type
				})
			);

		}

		variants = variants.map(
			( element, i ) => {

				return testVariant(
					validationPath = "#validationPath#.#i#",
					feature = feature,
					variant = arguments?.element
				);

			}
		);

		return variants;

	}

	// ---
	// PRIVATE VARIANT METHODS.
	// ---

	/**
	* I test the given variant.
	*/
	private any function testVariant(
		required string validationPath,
		required struct feature,
		any variant
		) {

		if ( isNull( variant ) ) {

			throw(
				type = "App.Model.Config.Variant.Missing",
				extendedInfo = serializeJson({
					validationPath: validationPath,
					featureType: feature.type
				})
			);

		}

		switch ( feature.type ) {
			case "boolean":
				return testVariantAsBoolean(
					validationPath = validationPath,
					variant = variant
				);
			break;
			case "number":
				return testVariantAsNumber(
					validationPath = validationPath,
					variant = variant
				);
			break;
			case "string":
				return testVariantAsString(
					validationPath = validationPath,
					variant = variant
				);
			break;
			case "any":
				return testVariantAsAny(
					validationPath = validationPath,
					variant = variant
				);
			break;
			// Note: Since the type has already been validated, we don't need to worry
			// about having a default case.
		}

	}


	/**
	* I test the given variant as type: any.
	*/
	private any function testVariantAsAny(
		required string validationPath,
		required any variant
		) {

		// For "any" variants, the only requirement is that they can be serialized.
		// --
		// Note: We're passing it through the serialization life-cycle in order to make
		// sure we create a deep-copy of the given value.
		try {

			return deserializeJson( serializeJson( variant ) );

		} catch ( any error ) {

			throw(
				type = "App.Model.Config.Variant.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath,
					featureType: "any"
				})
			);

		}

	}


	/**
	* I test the given variant as type: Boolean.
	*/
	private boolean function testVariantAsBoolean(
		required string validationPath,
		required any variant
		) {

		if ( ! isBoolean( variant ) ) {

			throw(
				type = "App.Model.Config.Variant.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath,
					featureType: "boolean"
				})
			);

		}

		return !! variant;

	}


	/**
	* I test the given variant as type: number.
	*/
	private numeric function testVariantAsNumber(
		required string validationPath,
		required any variant
		) {

		if ( ! isNumeric( variant ) ) {

			throw(
				type = "App.Model.Config.Variant.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath,
					featureType: "number"
				})
			);

		}

		return val( variant );

	}


	/**
	* I test the given variant as type: string.
	*/
	private string function testVariantAsString(
		required string validationPath,
		required any variant
		) {

		if ( ! isSimpleValue( variant ) ) {

			throw(
				type = "App.Model.Config.Variant.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath,
					featureType: "string"
				})
			);

		}

		return toString( variant );

	}

	// ---
	// PRIVATE TARGETING METHODS.
	// ---

	/**
	* I test the given targeting.
	*/
	private struct function testTargeting(
		required string validationPath,
		required struct feature,
		any settings
		) {

		if ( isNull( settings ) ) {

			throw(
				type = "App.Model.Config.Targeting.Missing",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		if ( ! isStruct( settings ) ) {

			throw(
				type = "App.Model.Config.Targeting.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		var resolution = testTargetingResolution(
			validationPath = "#validationPath#.resolution",
			feature = feature,
			resolution = settings?.resolution
		);
		var rulesEnabled = testTargetingRulesEnabled(
			validationPath = "#validationPath#.rulesEnabled",
			rulesEnabled = settings?.rulesEnabled
		);
		var rules = testTargetingRules(
			validationPath = "#validationPath#.rules",
			feature = feature,
			rules = settings?.rules
		);

		return [
			resolution: resolution,
			rulesEnabled: rulesEnabled,
			rules: rules
		];

	}


	/**
	* I test the given targeting resolution.
	*/
	private struct function testTargetingResolution(
		required string validationPath,
		required struct feature,
		any resolution
		) {

		return testResolution( argumentCollection = arguments );

	}


	/**
	* I test the given targeting rules.
	*/
	private array function testTargetingRules(
		required string validationPath,
		required struct feature,
		any rules
		) {

		if ( isNull( rules ) ) {

			throw(
				type = "App.Model.Config.Targeting.Rules.Missing",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		if ( ! isArray( rules ) ) {

			throw(
				type = "App.Model.Config.Targeting.Rules.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		rules = rules.map(
			( element, i ) => {

				return testRule(
					validationPath = "#validationPath#.#i#",
					feature = feature,
					rule = arguments?.element
				);

			}
		);

		return rules;

	}


	/**
	* I test the given targeting rules enabled.
	*/
	private boolean function testTargetingRulesEnabled(
		required string validationPath,
		any rulesEnabled
		) {

		if ( isNull( rulesEnabled ) ) {

			throw(
				type = "App.Model.Config.Targeting.RulesEnabled.Missing",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		if ( ! isBoolean( rulesEnabled ) ) {

			throw(
				type = "App.Model.Config.Targeting.RulesEnabled.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		return !! rulesEnabled;

	}

	// ---
	// PRIVATE RESOLUTION METHODS.
	// ---

	/**
	* I test the given resolution.
	*/
	private struct function testResolution(
		required string validationPath,
		required struct feature,
		any resolution
		) {

		if ( isNull( resolution ) ) {

			throw(
				type = "App.Model.Config.Resolution.Missing",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		if ( ! isStruct( resolution ) ) {

			throw(
				type = "App.Model.Config.Resolution.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		var type = testResolutionType(
			validationPath = "#validationPath#.type",
			type = resolution?.type
		);

		switch ( type ) {
			case "selection":

				return testResolutionAsSelection(
					validationPath = validationPath,
					feature = feature,
					resolution = resolution,
					type = type
				);

			break;
			case "distribution":

				return testResolutionAsDistribution(
					validationPath = validationPath,
					feature = feature,
					resolution = resolution,
					type = type
				);

			break;
			case "variant":

				return testResolutionAsVariant(
					validationPath = validationPath,
					feature = feature,
					resolution = resolution,
					type = type
				);

			break;
			// Note: Since the type has already been validated, we don't need to worry
			// about having a default case.
		}

	}


	/**
	* I test the given resolution as type: distribution.
	*/
	private struct function testResolutionAsDistribution(
		required string validationPath,
		required struct feature,
		required struct resolution,
		required string type
		) {

		var distribution = testResolutionDistribution(
			validationPath = "#validationPath#.distribution",
			feature = feature,
			distribution = resolution?.distribution
		);

		return [
			type: type,
			distribution: distribution
		];

	}


	/**
	* I test the given resolution as type: selection.
	*/
	private struct function testResolutionAsSelection(
		required string validationPath,
		required struct feature,
		required struct resolution,
		required string type
		) {

		var selection = testResolutionSelection(
			validationPath = "#validationPath#.selection",
			feature = feature,
			selection = resolution?.selection
		);

		return [
			type: type,
			selection: selection
		];

	}


	/**
	* I test the given resolution as type: variant.
	*/
	private struct function testResolutionAsVariant(
		required string validationPath,
		required struct feature,
		required struct resolution,
		required string type
		) {

		var variant = testResolutionVariant(
			validationPath = "#validationPath#.variant",
			feature = feature,
			variant = resolution?.variant
		);

		return [
			type: type,
			variant: variant
		];

	}


	/**
	* I test the given resolution distribution.
	*/
	private array function testResolutionDistribution(
		required string validationPath,
		required struct feature,
		any distribution
		) {

		if ( isNull( distribution ) ) {

			throw(
				type = "App.Model.Config.Resolution.Distribution.Missing",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		if ( ! isArray( distribution ) ) {

			throw(
				type = "App.Model.Config.Resolution.Distribution.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		if ( feature.variants.len() != distribution.len() ) {

			throw(
				type = "App.Model.Config.Resolution.Distribution.Mismatch",
				extendedInfo = serializeJson({
					validationPath: validationPath,
					variantCount: feature.variants.len()
				})
			);

		}

		distribution = distribution.map(
			( element, i ) => {

				if ( ! isValid( "integer", element ) ) {

					throw(
						type = "App.Model.Config.Resolution.Distribution.Entry.Invalid",
						extendedInfo = serializeJson({
							validationPath: "#validationPath#.#i#"
						})
					);

				}

				return val( element );

			}
		);

		if ( distribution.sum() != 100 ) {

			throw(
				type = "App.Model.Config.Resolution.Distribution.InvalidTotal",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		return distribution;

	}


	/**
	* I test the given resolution selection.
	*/
	private numeric function testResolutionSelection(
		required string validationPath,
		required struct feature,
		any selection
		) {

		if ( isNull( selection ) ) {

			throw(
				type = "App.Model.Config.Resolution.Selection.Missing",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		if ( ! isValid( "integer", selection ) ) {

			throw(
				type = "App.Model.Config.Resolution.Selection.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath,
					variantCount: feature.variants.len()
				})
			);

		}

		selection = val( selection );

		if ( ! feature.variants.isDefined( selection ) ) {

			throw(
				type = "App.Model.Config.Resolution.Selection.OutOfBounds",
				extendedInfo = serializeJson({
					validationPath: validationPath,
					variantCount: feature.variants.len()
				})
			);

		}

		return selection;

	}


	/**
	* I test the given resolution type.
	*/
	private string function testResolutionType(
		required string validationPath,
		any type
		) {

		if ( isNull( type ) ) {

			throw(
				type = "App.Model.Config.Resolution.Type.Missing",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		if ( ! isSimpleValue( type ) ) {

			throw(
				type = "App.Model.Config.Resolution.Type.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		switch ( type ) {
			case "selection":
			case "distribution":
			case "variant":
				return type.lcase();
			break;
		}

		throw(
			type = "App.Model.Config.Resolution.Type.Invalid",
			extendedInfo = serializeJson({
				validationPath: validationPath
			})
		);

	}


	/**
	* I test the given resolution variant.
	*/
	private any function testResolutionVariant(
		required string validationPath,
		required struct feature,
		any variant
		) {

		return testVariant( argumentCollection = arguments );

	}

	// ---
	// PRIVATE RULE METHODS.
	// ---

	/**
	* I test the given rule.
	*/
	private struct function testRule(
		required string validationPath,
		required struct feature,
		any rule
		) {

		if ( isNull( rule ) ) {

			throw(
				type = "App.Model.Config.Rule.Missing",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		if ( ! isStruct( rule ) ) {

			throw(
				type = "App.Model.Config.Rule.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		var operator = testRuleOperator(
			validationPath = "#validationPath#.operator",
			feature = feature,
			operator = rule?.operator
		);
		var input = testRuleInput(
			validationPath = "#validationPath#.input",
			feature = feature,
			input = rule?.input
		);
		var values = testRuleValues(
			validationPath = "#validationPath#.values",
			feature = feature,
			operator = operator,
			values = rule?.values
		);
		var resolution = testRuleResolution(
			validationPath = "#validationPath#.resolution",
			feature = feature,
			resolution = rule?.resolution
		);

		return [
			operator: operator,
			input: input,
			values: values,
			resolution: resolution
		];

	}


	/**
	* I test the given rule input.
	*/
	private string function testRuleInput(
		required string validationPath,
		required struct feature,
		any input
		) {

		if ( isNull( input ) ) {

			throw(
				type = "App.Model.Config.Rule.Input.Missing",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		if ( ! isSimpleValue( input ) ) {

			throw(
				type = "App.Model.Config.Rule.Input.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		input = toString( input ).trim();

		if ( ! input.len() ) {

			throw(
				type = "App.Model.Config.Rule.Input.Empty",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		return input;

	}


	/**
	* I test the given rule operator.
	*/
	private string function testRuleOperator(
		required string validationPath,
		required struct feature,
		any operator
		) {

		if ( isNull( operator ) ) {

			throw(
				type = "App.Model.Config.Rule.Operator.Missing",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		if ( ! isSimpleValue( operator ) ) {

			throw(
				type = "App.Model.Config.Rule.Operator.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		var knownOperators = [
			"Contains",
			"EndsWith",
			"IsOneOf",
			"MatchesPattern",
			"NotContains",
			"NotEndsWith",
			"NotIsOneOf",
			"NotMatchesPattern",
			"NotStartsWith",
			"StartsWith"
		];

		for ( var knownOperator in knownOperators ) {

			if ( operator == knownOperator ) {

				return knownOperator;

			}

		}

		throw(
			type = "App.Model.Config.Rule.Operator.Unsupported",
			extendedInfo = serializeJson({
				validationPath: validationPath,
				operatorList: knownOperators.toList( ", " )
			})
		);

	}


	/**
	* I test the given rule resolution.
	*/
	private struct function testRuleResolution(
		required string validationPath,
		required struct feature,
		any resolution
		) {

		return testResolution( argumentCollection = arguments );

	}


	/**
	* I test the given rule values.
	*/
	private array function testRuleValues(
		required string validationPath,
		required struct feature,
		required string operator,
		any values
		) {

		if ( isNull( values ) ) {

			throw(
				type = "App.Model.Config.Rule.Values.Missing",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		if ( ! isArray( values ) ) {

			throw(
				type = "App.Model.Config.Rule.Values.Invalid",
				extendedInfo = serializeJson({
					validationPath: validationPath
				})
			);

		}

		values = values.map(
			( element, i ) => {

				if ( ! isSimpleValue( element ) ) {

					throw(
						type = "App.Model.Config.Rule.Values.Entry.Invalid",
						extendedInfo = serializeJson({
							validationPath: "#validationPath#.#i#"
						})
					);

				}

				switch ( operator ) {
					case "Contains":
					case "EndsWith":
					case "MatchesPattern":
					case "NotContains":
					case "NotEndsWith":
					case "NotMatchesPattern":
					case "NotStartsWith":
					case "StartsWith":
						element = toString( element );
					break;
				}

				switch ( operator ) {
					case "MatchesPattern":
					case "NotMatchesPattern":

						// For RegEx-based operators, we need to make sure that the given
						// value can actually be parsed as a RegEx pattern.
						try {

							var result = reFind( element, "" );

						} catch ( any operatorError ) {

							throw(
								type = "App.Model.Config.Rule.Values.Entry.BadPattern",
								extendedInfo = serializeJson({
									validationPath: "#validationPath#.#i#"
								})
							);

						}

					break;
				}

				return element;

			}
		);

		return values;

	}

}
