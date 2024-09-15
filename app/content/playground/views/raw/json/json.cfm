<cfscript>

	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	config = getConfig( request.user.email );
	title = request.template.title = "Raw JSON Data";

	include "./json.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the config data for the given authenticated user.
	*/
	private struct function getConfig( required string email ) {

		return featureWorkflow.getConfig( email );

	}

</cfscript>
