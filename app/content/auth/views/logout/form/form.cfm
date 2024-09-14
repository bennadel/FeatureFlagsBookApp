<cfscript>

	authWorkflow = request.ioc.get( "lib.workflow.AuthWorkflow" );
	requestHelper = request.ioc.get( "lib.RequestHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="form.submitted" type="boolean" default=false;

	errorMessage = "";

	try {

		if ( form.submitted ) {

			authWorkflow.logout();

			requestHelper.goto( "auth.logout.success" );

		}

	} catch ( any error ) {

		errorMessage = requestHelper.processError( error );

	}

	request.template.title = "Log Out";

	include "./form.view.cfm";

</cfscript>
