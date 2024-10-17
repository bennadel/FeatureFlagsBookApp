<cfscript>

	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "client.main.lib.RequestHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="form.submitted" type="boolean" default=false;

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

</cfscript>
