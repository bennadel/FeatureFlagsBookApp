<cfscript>

	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "core.lib.RequestHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="form.submitted" type="boolean" default=false;

	config = getConfig( request.user.email );
	title = request.template.title = "Reset Feature Flag Configuration";
	errorMessage = "";

	if ( form.submitted ) {

		try {

			featureWorkflow.resetConfig( request.user.email );

			requestHelper.goto();

		} catch ( any error ) {

			errorMessage = requestHelper.processError( error );

		}

	}

	include "./reset.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the config data for the given authenticated user.
	*/
	private struct function getConfig( required string email ) {

		return featureWorkflow.getConfig( email );

	}

</cfscript>
