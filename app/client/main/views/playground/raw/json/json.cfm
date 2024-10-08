<cfscript>

	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	config = getConfig( request.user.email );
	title = "Raw JSON Data";

	request.template.title = title;

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
