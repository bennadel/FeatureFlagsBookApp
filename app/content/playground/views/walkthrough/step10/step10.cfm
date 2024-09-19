<cfscript>

	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	config = getConfig( request.user.email );
	// Reset the feature settings to the expected state for this step.
	feature = config.features[ request.walkthroughFeature.key ] = request.walkthroughFeature.settings;
	feature
		.targeting
			.development
				.resolution = {
					type: "selection",
					selection: 2
				}
	;
	feature
		.targeting
			.production
				.resolution = {
					type: "distribution",
					distribution: [ 0, 100 ]
				}
	;
	feature
		.targeting
			.production
				.rulesEnabled = true
	;
	feature
		.targeting
			.production
				.rules = [
					{
						input: "user.email",
						operator: "IsOneOf",
						values: [ request.user.email ],
						resolution: {
							type: "selection",
							selection: 2
						}
					},
					{
						input: "user.company.subdomain",
						operator: "IsOneOf",
						values: [ "devteam", "dayknight" ],
						resolution: {
							type: "selection",
							selection: 2
						}
					}
				]
	;
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
