<cfscript>

	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	config = getConfig( request.user.email );
	// Reset the feature settings to the expected state for this step.
	config.features[ request.featureKey ] = request.feature;
	// Reset the stored config.
	featureWorkflow.updateConfig(
		email = request.user.email,
		config = config
	);

	title = request.template.title = "Initial Feature State";

	include "./step2.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the config data for the given authenticated user.
	*/
	private struct function getConfig( required string email ) {

		return featureWorkflow.getConfig( email );

	}

</cfscript>
