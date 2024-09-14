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
	param name="form.ruleData" type="string" default="";
	param name="form.submitted" type="boolean" default=false;

	partial = getPartial(
		email = request.user.email,
		featureKey = request.context.featureKey,
		environmentKey = request.context.environmentKey
	);

	// Editing an existing rule.
	if ( request.context.ruleIndex && partial.rules.isDefined( request.context.ruleIndex ) ) {

		rule = partial.rules[ request.context.ruleIndex ];

	// Adding a new rule.
	} else {

		// Force index to be zero as a safe-guard.
		request.context.ruleIndex = 0;

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

	errorMessage = "";

	if ( form.submitted ) {

		try {

			if ( request.context.ruleIndex ) {

				partial.config
					.features[ partial.feature.key ]
						.targeting[ partial.environment.key ]
							.rules[ request.context.ruleIndex ] = deserializeJson( form.ruleData )
				;

			} else {

				partial.config
					.features[ partial.feature.key ]
						.targeting[ partial.environment.key ]
							.rules
								.append( deserializeJson( form.ruleData ) )
				;

			}

			featureWorkflow.updateConfig(
				email = request.user.email,
				config = partial.config
			);

			requestHelper.goto(
				[
					event: "playground.features.targeting",
					featureKey: partial.feature.key
				],
				"environment-#partial.environment.key#"
			);

		} catch ( any error ) {

			errorMessage = requestHelper.processError( error );

		}

	} else {

		form.ruleData = serializeJson( rule );

	}

	request.template.title = partial.title;

	include "./rule.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the main partial payload for the view.
	*/
	private struct function getPartial(
		required string email,
		required string  featureKey,
		required string  environmentKey
		) {

		var config = getConfig( email );
		var feature = getFeature( config, featureKey );
		var environment = getEnvironment( config, environmentKey );
		var rules = getRules( feature, environment );
		var datalists = getDatalists( email );

		return {
			config: config,
			feature: feature,
			environment: environment,
			rules: rules,
			datalists: datalists,
			title: "Rule"
		};

	}


	/**
	* I get the config data for the given authenticated user.
	*/
	private struct function getConfig( required string email ) {

		return featureWorkflow.getConfig( email );

	}


	/**
	* I get the data lists for the demo users.
	*/
	private struct function getDatalists( required string email ) {

		return demoTargeting.getDatalists( demoUsers.getUsers( email ) );

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
