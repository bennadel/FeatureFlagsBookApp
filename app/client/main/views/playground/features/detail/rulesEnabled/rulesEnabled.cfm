<cfscript>

	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	partialHelper = request.ioc.get( "client.main.views.common.lib.PartialHelper" );
	requestHelper = request.ioc.get( "client.common.lib.RequestHelper" );
	ui = request.ioc.get( "client.common.lib.ViewHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.context.featureKey" type="string" default="";
	param name="request.context.environmentKey" type="string" default="";
	param name="form.rulesEnabled" type="boolean" default=false;
	param name="form.submitted" type="boolean" default=false;

	config = partialHelper.getConfig( request.user.email );
	feature = partialHelper.getFeature( config, request.context.featureKey );
	environment = partialHelper.getEnvironment( config, request.context.environmentKey );
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

</cfscript>
