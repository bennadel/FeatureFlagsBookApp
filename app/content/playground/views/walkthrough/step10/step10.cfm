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

	title = request.template.title = "Soaking in Production";

	include "./step10.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the config data for the given authenticated user.
	*/
	private struct function getConfig( required string email ) {

		return featureWorkflow.getConfig( email );

	}

</cfscript>
