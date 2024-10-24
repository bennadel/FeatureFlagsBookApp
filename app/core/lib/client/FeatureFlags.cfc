/**
* Note: I had originally designed the client to work without dependency injection (DI) so
* that it would more closely mimic an external use-case (being more standalone). But, for
* performance reasons, I'm going to cache the client in memory and allow the config object
* to be passed-in on each feature flag evaluation.
*/
component
	output = false
	hint = "I evaluate resolve feature flag settings against a given context."
	{

	// Define properties for dependency-injection.
	property name="ioc" ioc:type="core.lib.Injector";
	property name="logger" ioc:type="core.lib.Logger";
	property name="operatorStrategies" ioc:skip;
	property name="resolutionStrategies" ioc:skip;

	/**
	* I initialize the feature flags client.
	*/
	public void function $init() {

		variables.operatorStrategies = {
			Contains: ioc.get( "core.lib.client.operator.Contains" ),
			EndsWith: ioc.get( "core.lib.client.operator.EndsWith" ),
			IsOneOf: ioc.get( "core.lib.client.operator.IsOneOf" ),
			MatchesPattern: ioc.get( "core.lib.client.operator.MatchesPattern" ),
			NotContains: ioc.get( "core.lib.client.operator.NotContains" ),
			NotEndsWith: ioc.get( "core.lib.client.operator.NotEndsWith" ),
			NotIsOneOf: ioc.get( "core.lib.client.operator.NotIsOneOf" ),
			NotMatchesPattern: ioc.get( "core.lib.client.operator.NotMatchesPattern" ),
			NotStartsWith: ioc.get( "core.lib.client.operator.NotStartsWith" ),
			StartsWith: ioc.get( "core.lib.client.operator.StartsWith" )
		};
		variables.resolutionStrategies = {
			Distribution: ioc.get( "core.lib.client.resolution.Distribution" ),
			Selection: ioc.get( "core.lib.client.resolution.Selection" ),
			Variant: ioc.get( "core.lib.client.resolution.Variant" )
		};

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get the variant that resolves against the given context properties. However,
	* instead of returning the variant alone, I return both the variant and the details
	* about why the given variant was ultimately selected.
	*/
	public struct function debugEvaluation(
		required struct config,
		required string featureKey,
		required string environmentKey,
		required struct context,
		required any fallbackVariant
		) {

		var result = {
			arguments: {
				featureKey: featureKey,
				environmentKey: environmentKey,
				context: context,
				fallbackVariant: fallbackVariant
			},
			reason: "Unknown",
			errorMessage: "",
			feature: "Unknown",
			evaluatedRules: "Unknown",
			skippedRules: "Unknown",
			matchingRuleIndex: 0,
			resolution: "Unknown",
			variant: fallbackVariant,
			variantIndex: 0
		};

		try {

			// The context key is what associates the current request with a targetable
			// entity. It is also used to drive percent-based distributions and other
			// custom rule logic.
			if ( ! context.keyExists( "key" ) ) {

				result.reason = "MissingContextKey";
				return result;

			}

			// Since the context key is used to drive percent-based distributions, it
			// needs to be a simple value such that it can be cast to a string and then
			// subsequently used to drive a CRC-32 checksum which can then be used in a
			// modulo operation (see core.lib.client.resolution.Distribution.cfc).
			if ( ! isSimpleValue( context.key ) ) {

				result.reason = "ComplexContextKey";
				return result;

			}

			if ( ! config.keyExists( "features" ) ) {

				result.reason = "EmptyConfig";
				return result;

			}

			if ( ! config.features.keyExists( featureKey ) ) {

				result.reason = "MissingFeature";
				return result;

			}

			// Note: If the "features" key exists (above condition), we're going to assume
			// that the nested "targeting" key exists as well since there will be some
			// validation applied to the config structure (at least in theory).
			if ( ! config.features[ featureKey ].targeting.keyExists( environmentKey ) ) {

				result.reason = "MissingEnvironment";
				return result;

			}

			var feature = config.features[ featureKey ];
			var targeting = feature.targeting[ environmentKey ];
			var variants = feature.variants;
			// This is the default resolution associated with the targeted environment.
			// The rule evaluations below may override this resolution (using the first
			// matching rule as the override source). But, if none of the rules match,
			// this is the resolution strategy that we'll use when selecting the variant.
			var resolution = targeting.resolution;

			result.reason = "DefaultResolution";
			result.feature = feature;
			result.evaluatedRules = [];
			result.skippedRules = [];
			result.resolution = resolution;

			if ( targeting.rulesEnabled ) {

				var ruleIndex = 0;

				for ( var rule in targeting.rules ) {

					ruleIndex++;

					if ( ! context.keyExists( rule.input ) ) {

						result.skippedRules.append({
							reason: "NoMatchingInput",
							rule: rule
						});
						continue;

					}

					// In order for the operators within this simplified demo to work,
					// they all assume that the context input is a simple value. This way,
					// they can rely on equality comparisons (and auto type-casting)
					// without complex inspection logic.
					if ( ! isSimpleValue( context[ rule.input ] ) ) {

						result.skippedRules.append({
							reason: "NonSimpleInput",
							rule: rule
						});
						continue;

					}

					result.evaluatedRules.append( rule );

					var operator = operatorStrategies[ rule.operator ];
					var contextValue = context[ rule.input ];
					var values = rule.values;

					if ( operator.test( contextValue, values ) ) {

						// If this rule matches the provided context value, then use the
						// rule to override the default resolution of the environment.
						result.reason = "MatchingRule";
						result.resolution = resolution = rule.resolution;
						result.matchingRuleIndex = ruleIndex;
						// First matching rule wins - no need to keep checking rules.
						break;

					}

				}

			}

			result.variant = resolutionStrategies[ resolution.type ].getVariant(
				key = context.key,
				variants = variants,
				resolution = resolution
			);
			result.variantIndex = ( resolution.type == "variant" )
				? 0
				: arrayFind( variants, result.variant )
			;

			return result;

		} catch ( any error ) {

			logger.logException( error );

			result.reason = "Error";
			result.errorMessage = "[#error.type#] #error.message#";
			result.variant = fallbackVariant;
			result.variantIndex = 0;
			return result;

		}

	}


	/**
	* I get the variant that resolves against the given context properties. The fallback
	* variant is used to decrease the chances that a client-side error will occur if an
	* invalid request is made against the current configuration. Basically, the fallback
	* variant is returned anytime something goes "wrong" in the feature flag evaluation.
	*/
	public any function getVariant(
		required struct config,
		required string featureKey,
		required string environmentKey,
		required struct context,
		required any fallbackVariant
		) {

		// Note: Since this is a "learning app", I'm not worried about performance. As
		// such, I'm funneling all evaluations through the debug method and then plucking
		// out the resultant variant. This way, I don't have to duplicate the logic in
		// two different methods.
		var result = debugEvaluation( argumentCollection = arguments );

		return result.variant;

	}

}
