<cfscript>

	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	partialHelper = request.ioc.get( "client.main.views.common.lib.PartialHelper" );

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
			],
			[
				input: "user.company.subdomain",
				operator: "IsOneOf",
				values: [ "devteam" ],
				resolution: [
					type: "selection",
					selection: 2
				]
			],
			// Note: This rule could be combined with the above rule. However, in order to
			// make the highlighting of changes easier, I'm leaving it as its own rule.
			[
				input: "user.company.subdomain",
				operator: "IsOneOf",
				values: [ "dayknight" ],
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

	title = request.template.title = "Instantaneous Roll-Back";

	include "./step6b.view.cfm";

</cfscript>
