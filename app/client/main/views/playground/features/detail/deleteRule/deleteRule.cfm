<cfscript>

	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	partialHelper = request.ioc.get( "client.main.views.common.lib.PartialHelper" );
	requestHelper = request.ioc.get( "core.lib.RequestHelper" );
	utilities = request.ioc.get( "core.lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.context.featureKey" type="string" default="";
	param name="request.context.environmentKey" type="string" default="";
	param name="request.context.ruleIndex" type="numeric" default=0;
	param name="form.submitted" type="boolean" default=false;

	config = partialHelper.getConfig( request.user.email );
	feature = partialHelper.getFeature( config, request.context.featureKey );
	environment = partialHelper.getEnvironment( config, request.context.environmentKey );
	ruleIndex = val( request.context.ruleIndex );
	rule = partialHelper.getRule( feature, environment, ruleIndex );
	title = "Delete Rule";
	errorMessage = "";

	request.template.title = title;
	request.template.video = "feature-delete-rule";

	if ( form.submitted ) {

		try {

			featureWorkflow.deleteRule(
				email = request.user.email,
				featureKey = feature.key,
				environmentKey = environment.key,
				ruleIndex = ruleIndex
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

	}

	include "./deleteRule.view.cfm";

</cfscript>
