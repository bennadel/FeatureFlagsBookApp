<cfscript>

	configValidation = request.ioc.get( "core.lib.model.config.ConfigValidation" );
	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "core.lib.RequestHelper" );
	ui = request.ioc.get( "client.common.lib.ViewHelper" );
	utilities = request.ioc.get( "core.lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.context.featureKey" type="string" default="";
	param name="request.context.environmentKey" type="string" default="";
	param name="form.rulesEnabled" type="boolean" default=false;
	param name="form.submitted" type="boolean" default=false;


	config = getConfig( request.user.email );
	feature = getFeature( config, request.context.featureKey );
	environment = getEnvironment( config, request.context.environmentKey );
	title = "Rules Enabled";
	errorMessage = "";

	request.template.title = title;
	request.template.video = "feature-rules-enabled";

	if ( form.submitted ) {

		try {

			featureWorkflow.updateRulesEnabled(
				email = request.user.email,
				featureKey = feature.key,
				environmentKey = environment.key,
				rulesEnabled = !! form.rulesEnabled
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

		form.rulesEnabled = feature.targeting[ environment.key ].rulesEnabled;

	}

	include "./rulesEnabled.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

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
