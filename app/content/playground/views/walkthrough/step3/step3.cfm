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
	// Reset the stored config.
	featureWorkflow.updateConfig(
		email = request.user.email,
		config = config
	);

	title = request.template.title = "Enable in Development Environment";

	include "./step3.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the config data for the given authenticated user.
	*/
	private struct function getConfig( required string email ) {

		return featureWorkflow.getConfig( email );

	}

</cfscript>
