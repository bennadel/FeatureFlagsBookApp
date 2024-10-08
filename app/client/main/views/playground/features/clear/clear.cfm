<cfscript>

	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "core.lib.RequestHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="form.submitted" type="boolean" default=false;

	config = getConfig( request.user.email );
	title = "Remove Feature Flag Rules";
	errorMessage = "";

	request.template.title = title;
	request.template.video = "features-clear";

	if ( form.submitted ) {

		try {

			featureWorkflow.clearConfig( request.user.email );

			requestHelper.goto();

		} catch ( any error ) {

			errorMessage = requestHelper.processError( error );

		}

	}

	include "./clear.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the config data for the given authenticated user.
	*/
	private struct function getConfig( required string email ) {

		return featureWorkflow.getConfig( email );

	}

</cfscript>
