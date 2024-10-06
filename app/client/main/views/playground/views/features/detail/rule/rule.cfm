<cfscript>

	configValidation = request.ioc.get( "core.lib.model.config.ConfigValidation" );
	demoTargeting = request.ioc.get( "core.lib.demo.DemoTargeting" );
	demoUsers = request.ioc.get( "core.lib.demo.DemoUsers" );
	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "core.lib.RequestHelper" );
	ui = request.ioc.get( "client.common.lib.ViewHelper" );
	utilities = request.ioc.get( "core.lib.util.Utilities" );

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
	operators = getOperators();
	inputs = getInputs();
	title = request.template.title = ( ruleIndex )
		? "Edit Rule"
		: "Add Rule"
	;
	errorMessage = "";

	if ( ruleIndex && ! rules.isDefined( ruleIndex ) ) {

		configValidation.throwRuleNotFoundError();

	}

	if ( form.submitted ) {

		try {

			// Clean-up the form values a bit. All the values are submitted as strings;
			// but we can remove empty ones and cast certain patterns based on the
			// selected input. Ultimately, we could store everything as a string; but, for
			// a better UI experience, it's nicer when things are cast.
			form.values = form.values
				.filter(
					( value ) => {

						return value.trim().len();

					}
				)
				.map(
					( value ) => {

						value = value.trim();

						switch ( form.input ) {
							case "key":
							case "user.id":
							case "user.company.id":

								// Note: Jumping through hoops here because ColdFusion
								// will sometimes cast numeric values to have a decimal
								// place and I want integers to render as integers.
								if ( isValid( "integer", value ) ) {

									return javaCast( "int", value );

								} else if ( isNumeric( value ) ) {

									return val( value );

								}

							break;
							case "user.company.fortune100":
							case "user.company.fortune500":
							case "user.groups.betaTester":
							case "user.groups.influencer":

								if (
									! compare( value, "true" ) ||
									! compare( value, "false" )
									) {

									return !! value;

								}

							break;
						}

						return value;

					}
				)
			;

			// Note: We can store dirty data into the resolution configuration - the
			// validation process will skip-over anything that isn't relevant to the
			// given resolution type.
			rule = [
				operator: form.operator,
				input: form.input,
				values: form.values,
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
	* I get the list of available inputs.
	*/
	private array function getInputs() {

		return demoTargeting.getInputs();

	}


	/**
	* I get the list of available operators.
	*/
	private array function getOperators() {

		return demoTargeting.getOperators();

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
