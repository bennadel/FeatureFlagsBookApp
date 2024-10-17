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
	feature.targeting.production = [
		resolution: [
			type: "selection",
			selection: 1
		],
		rulesEnabled: true,
		rules: [
			[
				input: "user.email",
				operator: "IsOneOf",
				values: [ request.user.email ],
				resolution: [
					type: "selection",
					selection: 2
				]
			]
		]
	];

	// Reset the stored config.
	featureWorkflow.updateConfig(
		email = request.user.email,
		config = config
	);

	title = request.template.title = "Solo Testing in Production";

	include "./step4.view.cfm";

</cfscript>
