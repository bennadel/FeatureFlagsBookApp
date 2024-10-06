<cfscript>

	authWorkflow = request.ioc.get( "core.lib.workflow.AuthWorkflow" );
	requestHelper = request.ioc.get( "core.lib.RequestHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="form.submitted" type="boolean" default=false;

	request.template.title = "Log Out";
	errorMessage = "";

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
