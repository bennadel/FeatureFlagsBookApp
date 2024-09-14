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

	config = getConfig( request.user.email );
	feature = getFeature( config, request.context.featureKey );
	environment = getEnvironment( config, request.context.environmentKey );
	ruleIndex = val( request.context.ruleIndex );
	rules = getRules( feature, environment );
	datalists = getDatalists( request.user.email );
	title = request.template.title = "Rule";
	errorMessage = "";

	// Editing an existing rule.
	if ( ruleIndex && rules.isDefined( ruleIndex ) ) {

		rule = rules[ ruleIndex ];

	// Adding a new rule.
	} else {

		// Force index to be zero as a safe-guard.
		ruleIndex = 0;
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
	
	if ( form.submitted ) {

		try {

			if ( ruleIndex ) {

				config
					.features[ feature.key ]
						.targeting[ environment.key ]
							.rules[ ruleIndex ] = deserializeJson( form.ruleData )
				;

			} else {

				config
					.features[ feature.key ]
						.targeting[ environment.key ]
							.rules
								.append( deserializeJson( form.ruleData ) )
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

		form.ruleData = serializeJson( rule );

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
