component
	output = false
	hint = "I evaluate resolve feature flag settings against a given context."
	{

	/**
	* I initialize the feature flags client.
	*
	* Note: None of the component instantiation in the "client" area uses the Dependency
	* Injection container (ioc). I wanted this to feel more "standalone", when compared to
	* the rest of the playground application.
	*/
	public void function init() {

		variables.operatorStrategies = {
			Contains: new lib.client.operator.Contains(),
			EndsWith: new lib.client.operator.EndsWith(),
			IsOneOf: new lib.client.operator.IsOneOf(),
			MatchesPattern: new lib.client.operator.MatchesPattern(),
			NotContains: new lib.client.operator.NotContains(),
			NotEndsWith: new lib.client.operator.NotEndsWith(),
			NotIsOneOf: new lib.client.operator.NotIsOneOf(),
			NotMatchesPattern: new lib.client.operator.NotMatchesPattern(),
			NotStartsWith: new lib.client.operator.NotStartsWith(),
			StartsWith: new lib.client.operator.StartsWith()
		};
		variables.resolutionStrategies = {
			Distribution: new lib.client.resolution.Distribution(),
			Selection: new lib.client.resolution.Selection(),
			Variant: new lib.client.resolution.Variant()
		};

		variables.logger = new lib.client.util.Logger();
		variables.config = {};

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get the variant that resolves against the given context properties. The fallback
	* variant is used to decrease the chances that a client-side error will occur if an
	* invalid request is made against the current configuration. Basically, the fallback
	* variant is returned anytime something goes "wrong" in the feature flag evaluation.
	*/
	public any function getVariant(
		required string feature,
		required string environment,
		required struct context,
		required any fallbackVariant
		) {

		// Note: The key check is not in the try/catch because a missing key represents an
		// Bad Request, not a mismatch between the context and the configuration.
		if (
			! context.keyExists( "key" ) ||
			! isSimpleValue( context.key )
			) {

			throw(
				type = "ContextKeyMissing",
				message = "The context struct must contain a simple [key] that is unique to targeted entity."
			);

		}

		try {

			// Note: If the "features" key exists, we're going to assume that the nested
			// "environments" key exists as well since there will be some validation
			// applied to the config structure (at least in theory).
			if (
				! config.keyExists( "features" ) ||
				! config.features.keyExists( feature ) ||
				! config.features[ feature ].environments.keyExists( environment )
				) {

				return fallbackVariant;

			}

			var featureSettings = config.features[ feature ];
			var environmentSettings = featureSettings.environments[ environment ];
			var variants = featureSettings.variants;
			// This is the default resolution associated with the targeted environment.
			// The rule evaluations below may override this resolution (using the first
			// matching rule as the override source).
			var resolution = environmentSettings.resolution;

			if ( environmentSettings.rulesEnabled ) {

				for ( var rule in environmentSettings.rules ) {

					if ( ! context.keyExists( rule.input ) ) {

						continue;

					}

					// In order for the operators within this simplified demo to work,
					// they all assume that the context input is a simple value. This way,
					// they can rely on equality comparisons (and auto type-casting)
					// without complex inspection logic.
					if ( ! isSimpleValue( context[ rule.input ] ) ) {

						continue;

					}

					var operator = operatorStrategies[ rule.operator ];
					var contextValue = context[ rule.input ];
					var values = rule.values;

					if ( operator.test( contextValue, values ) ) {

						// If this rule matches the provided context value, then use the
						// rule to override the default resolution of the environment.
						resolution = rule.resolution;
						// First matching rule wins - no need to keep checking rules.
						break;

					}

				}

			}

			return resolutionStrategies[ resolution.type ].getVariant(
				key = context.key,
				variants = variants,
				resolution = resolution
			);

		} catch ( any error ) {

			logger.logException( error );

			return fallbackVariant;

		}

	}


	/**
	* I update the stored configuration for the feature flags targeting.
	*/
	public any function withConfig( required struct config ) {

		variables.config = arguments.config;

		return this;

	}


	/**
	* I update the stored logger for reporting errors.
	*/
	public any function withLogger( required any logger ) {

		variables.logger = arguments.logger;

		return this;

	}

}
