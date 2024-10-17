<cfscript>

	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "client.common.lib.RequestHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="form.submitted" type="boolean" default=false;

	title = "Reset Feature Flag Configuration";
	errorMessage = "";

	request.template.title = title;
	request.template.video = "features-reset";

	if ( form.submitted ) {

		try {

			featureWorkflow.resetConfig( request.user.email );

			requestHelper.goto();

		} catch ( any error ) {

			errorMessage = requestHelper.processError( error );

		}

	}

	include "./reset.view.cfm";

</cfscript>
