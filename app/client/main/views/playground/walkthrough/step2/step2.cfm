<cfscript>

	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	partialHelper = request.ioc.get( "client.main.lib.PartialHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	config = partialHelper.getConfig( request.user.email );
	// Reset the feature settings to the expected state for this step.
	config.features[ request.featureKey ] = request.feature;
	// Reset the stored config.
	featureWorkflow.updateConfig(
		email = request.user.email,
		config = config
	);

	title = request.template.title = "Initial Feature State";

	include "./step2.view.cfm";

</cfscript>
