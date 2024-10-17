<cfscript>

	authWorkflow = request.ioc.get( "client.main.lib.workflow.AuthWorkflow" );
	requestHelper = request.ioc.get( "client.main.lib.RequestHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="form.submitted" type="boolean" default=false;

	title = "Log Out";
	errorMessage = "";

	request.template.title = title;

	try {

		if ( form.submitted ) {

			authWorkflow.logout();

			requestHelper.goto( "auth.logout.success" );

		}

	} catch ( any error ) {

		errorMessage = requestHelper.processError( error );

	}

	include "./form.view.cfm";

</cfscript>
