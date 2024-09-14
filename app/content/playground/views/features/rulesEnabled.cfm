<cfscript>

	configValidation = request.ioc.get( "lib.model.config.ConfigValidation" );
	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "lib.RequestHelper" );
	utilities = request.ioc.get( "lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.context.featureKey" type="string" default="";
	param name="request.context.environmentKey" type="string" default="";
	param name="form.rulesEnabled" type="boolean" default=false;
	param name="form.submitted" type="boolean" default=false;

	partial = getPartial(
		email = request.user.email,
		featureKey = request.context.featureKey,
		environmentKey = request.context.environmentKey
	);

	errorMessage = "";

	if ( form.submitted ) {

		try {

			partial.config
				.features[ partial.feature.key ]
					.targeting[ partial.environment.key ]
						.rulesEnabled = !! form.rulesEnabled
			;

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

		form.rulesEnabled = partial.feature.targeting[ partial.environment.key ].rulesEnabled;

	}

	request.template.title = "Rules Enabled";

	include "./rulesEnabled.view.cfm";

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

		return {
			config: config,
			feature: feature,
			environment: environment,
			title: "Rules Enabled"
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

</cfscript>
