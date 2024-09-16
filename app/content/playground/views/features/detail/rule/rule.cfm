<cfscript>

	configValidation = request.ioc.get( "lib.model.config.ConfigValidation" );
	demoTargeting = request.ioc.get( "lib.demo.DemoTargeting" );
	demoUsers = request.ioc.get( "lib.demo.DemoUsers" );
	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "lib.RequestHelper" );
	utilities = request.ioc.get( "lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.context.featureKey" type="string" default="";
	param name="request.context.environmentKey" type="string" default="";
	param name="request.context.ruleIndex" type="numeric" default=0;
	param name="form.input" type="string" default="";
	param name="form.operator" type="string" default="";
	param name="form.values" type="array" default=[];
	param name="form.resolutionType" type="string" default="selection";
	param name="form.resolutionSelection" type="numeric" default=1;
	param name="form.resolutionDistribution" type="array" default=[];
	param name="form.resolutionVariant" type="any" default="";
	param name="form.submitted" type="boolean" default=false;

	config = getConfig( request.user.email );
	feature = getFeature( config, request.context.featureKey );
	environment = getEnvironment( config, request.context.environmentKey );
	ruleIndex = val( request.context.ruleIndex );
	rules = getRules( feature, environment );
	datalists = getDatalists( request.user.email );
	title = request.template.title = "Rule";
	errorMessage = "";

	if ( ruleIndex && ! rules.isDefined( ruleIndex ) ) {

		ruleIndex = 0;

	}

	operators = [
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
	inputs = [
		"key",
		"user.id",
		"user.email",
		"user.role",
		"user.company.id",
		"user.company.subdomain",
		"user.company.fortune100",
		"user.company.fortune500",
		"user.groups.betaTester",
		"user.groups.influencer"
	];

	
	if ( form.submitted ) {

		try {

			// Note: We can store dirty data into the resolution configuration - the
			// validation process will skip-over anything that isn't relevant to the
			// given resolution type.
			rule = [
				operator: form.operator,
				input: form.input,
				values: form.values.filter(
					( value ) => {

						return len( value );

					}
				),
				resolution: [
					type: form.resolutionType,
					selection: form.resolutionSelection,
					distribution: form.resolutionDistribution,
					variant: form.resolutionVariant
				]
			];

			if ( ruleIndex ) {

				config
					.features[ feature.key ]
						.targeting[ environment.key ]
							.rules[ ruleIndex ] = rule
				;

			} else {

				config
					.features[ feature.key ]
						.targeting[ environment.key ]
							.rules
								.append( rule )
				;

			}

			featureWorkflow.updateConfig(
				email = request.user.email,
				config = config
			);

			requestHelper.goto(
				[
					event: "playground.features.detail.targeting",
					featureKey: feature.key
				],
				"environment-#environment.key#"
			);

		} catch ( any error ) {

			errorMessage = requestHelper.processError( error );

		}

	} else {

		if ( ruleIndex ) {

			rule = rules[ ruleIndex ];

		} else {

			rule = [
				operator: "IsOneOf",
				input: "user.email",
				values: [],
				resolution: [
					type: "selection",
					selection: 1
				]
			];

		}

		form.input = rule.input;
		form.operator = rule.operator;
		form.values = rule.values;
		form.resolutionType = rule.resolution.type;

		if ( form.resolutionType == "selection" ) {

			form.resolutionSelection = rule.resolution.selection;

		} else {

			form.resolutionSelection = 1;

		}

		if ( form.resolutionType == "distribution" ) {

			form.resolutionDistribution = rule.resolution.distribution;

		} else {

			form.resolutionDistribution = feature.variants.map(
				( _, i ) => {

					return ( ( i == 1 ) ? 100 : 0 );

				}
			);

		}

		if ( form.resolutionType == "variant" ) {

			switch ( feature.type ) {
				case "string":
					form.resolutionVariant = rule.resolution.variant;
				break;
				default:
					form.resolutionVariant = serializeJson( rule.resolution.variant );
				break;
			}

		} else {

			switch ( feature.type ) {
				case "boolean":
					form.resolutionVariant = false;
				break;
				case "number":
					form.resolutionVariant = 0;
				break;
				default:
					form.resolutionVariant = "";
				break;
			}

		}

	}

	include "./rule.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the config data for the given authenticated user.
	*/
	private struct function getConfig( required string email ) {

		return featureWorkflow.getConfig( email );

	}


	/**
	* I get the data lists for the demo users.
	*/
	private array function getDatalists( required string email ) {

		return utilities.toEntries( demoTargeting.getDatalists( demoUsers.getUsers( email ) ) );

	}


	/**
	* I get the environment for the given key.
	*/
	private struct function getEnvironment(
		required struct config,
		required string environmentKey
		) {

		var environments = utilities.toEnvironmentsArray( config.environments );
		var environmentIndex = utilities.indexBy( environments, "key" );

		if ( ! environmentIndex.keyExists( environmentKey ) ) {

			configValidation.throwTargetingNotFoundError();

		}

		return environmentIndex[ environmentKey ];

	}


	/**
	* I get the feature for the given key.
	*/
	private struct function getFeature(
		required struct config,
		required string featureKey
		) {

		var features = utilities.toFeaturesArray( config.features );
		var featureIndex = utilities.indexBy( features, "key" );

		if ( ! featureIndex.keyExists( featureKey ) ) {

			configValidation.throwFeatureNotFoundError();

		}

		return featureIndex[ featureKey ];

	}


	/**
	* I get the rules in the given environment.
	*/
	private array function getRules(
		required struct feature,
		required struct environment
		) {

		return feature.targeting[ environment.key ].rules;

	}

</cfscript>