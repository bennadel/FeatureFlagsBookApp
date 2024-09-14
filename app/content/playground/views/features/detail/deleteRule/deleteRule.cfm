<cfscript>

	configValidation = request.ioc.get( "lib.model.config.ConfigValidation" );
	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "lib.RequestHelper" );
	utilities = request.ioc.get( "lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.context.featureKey" type="string" default="";
	param name="request.context.environmentKey" type="string" default="";
	param name="request.context.ruleIndex" type="numeric" default=0;
	param name="form.submitted" type="boolean" default=false;

	partial = getPartial(
		email = request.user.email,
		featureKey = request.context.featureKey,
		environmentKey = request.context.environmentKey,
		ruleIndex = val( request.context.ruleIndex )
	);

	errorMessage = "";

	if ( form.submitted ) {

		try {

			partial.config
				.features[ partial.feature.key ]
					.targeting[ partial.environment.key ]
						.rules
							.deleteAt( request.context.ruleIndex )
			;

			featureWorkflow.updateConfig(
				email = request.user.email,
				config = partial.config
			);

			requestHelper.goto(
				[
					event: "playground.features.detail.targeting",
					featureKey: partial.feature.key
				],
				"environment-#partial.environment.key#"
			);

		} catch ( any error ) {

			errorMessage = requestHelper.processError( error );

		}

	}

	request.template.title = partial.title;

	include "./deleteRule.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the main partial payload for the view.
	*/
	private struct function getPartial(
		required string email,
		required string  featureKey,
		required string  environmentKey,
		required numeric ruleIndex
		) {

		var config = getConfig( email );
		var feature = getFeature( config, featureKey );
		var environment = getEnvironment( config, environmentKey );
		var rule = getRule( feature, environment, ruleIndex );

		return {
			config: config,
			feature: feature,
			environment: environment,
			rule: rule,
			title: "Delete Rule"
		};

	}


	/**
	* I get the config data for the given authenticated user.
	*/
	private struct function getConfig( required string email ) {

		return featureWorkflow.getConfig( email );

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
	* I get the rule at the given index.
	*/
	private struct function getRule(
		required struct feature,
		required struct environment,
		required numeric ruleIndex
		) {

		var rules = feature.targeting[ environment.key ].rules;

		if ( ! rules.isDefined( ruleIndex ) ) {

			configValidation.throwRuleNotFoundError();

		}

		return rules[ ruleIndex ];

	}

</cfscript>
