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

			location(
				url = "/index.cfm?event=auth.logoutSuccess",
				addToken = false
			);

		}

	} catch ( any error ) {

		errorMessage = requestHelper.processError( error );

	}

	request.template.title = "Log Out";

	include "./logout.view.cfm";

</cfscript>
