<cfscript>

	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "client.main.lib.RequestHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="form.submitted" type="boolean" default=false;

	user = request.user;
	title = "Delete Account";
	errorMessage = "";

	request.template.title = title;

	if ( form.submitted ) {

		try {

			featureWorkflow.resetConfig( request.user.email );

			requestHelper.goto( "auth.logout" );

		} catch ( any error ) {

			errorMessage = requestHelper.processError( error );

		}

	}

	include "./delete.view.cfm";

</cfscript>
