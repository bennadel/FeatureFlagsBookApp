<cfscript>

	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	partialHelper = request.ioc.get( "client.main.lib.PartialHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	config = partialHelper.getConfig( request.user.email );
	// Reset the feature settings to the expected state for this step.
	feature = config.features[ request.featureKey ] = request.feature;
	feature.targeting.development = [
		resolution: [
			type: "selection",
			selection: 2
		],
		rulesEnabled: false,
		rules: []
	];

	// Reset the stored config.
	featureWorkflow.updateConfig(
		email = request.user.email,
		config = config
	);

	title = request.template.title = "Enable in Development Environment";

	include "./step3.view.cfm";

</cfscript>
