<cfscript>

	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	utilities = request.ioc.get( "core.lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	config = getConfig( request.user.email );
	// Reset the feature settings to the expected state for this step.
	config.features.delete( request.featureKey );

	// Reset the stored config.
	featureWorkflow.updateConfig(
		email = request.user.email,
		config = config
	);

	features = getFeatures( config );
	title = "Time For Your Next Challenge";

	request.template.title = title;

	include "./step11.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the config data for the given authenticated user.
	*/
	private struct function getConfig( required string email ) {

		return featureWorkflow.getConfig( email );

	}


	/**
	* I get the features for the given config.
	*/
	private array function getFeatures( required struct config ) {

		return utilities.toFeaturesArray( config.features );

	}

</cfscript>
