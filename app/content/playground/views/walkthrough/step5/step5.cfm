<cfscript>

	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	config = getConfig( request.user.email );
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
			]
		]
	];

	// Reset the stored config.
	featureWorkflow.updateConfig(
		email = request.user.email,
		config = config
	);

	title = request.template.title = "Internal Testing in Production";

	include "./step5.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the config data for the given authenticated user.
	*/
	private struct function getConfig( required string email ) {

		return featureWorkflow.getConfig( email );

	}

</cfscript>
