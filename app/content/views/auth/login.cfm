<cfscript>

	authWorkflow = request.ioc.get( "lib.workflow.AuthWorkflow" );
	config = request.ioc.get( "config" );
	requestHelper = request.ioc.get( "lib.RequestHelper" );
	requestMetadata = request.ioc.get( "lib.RequestMetadata" );
	turnstile = request.ioc.get( "lib.turnstile.Turnstile" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="form.submitted" type="boolean" default=false;
	param name="form.email" type="string" default="";
	param name="form[ 'cf-turnstile-response' ]" type="string" default="";

	errorMessage = "";

	if ( form.submitted && form.email.trim().len() ) {

		try {

			turnstile.testToken( form[ "cf-turnstile-response" ], requestMetadata.getIpAddress() );
			authWorkflow.login( form.email.trim() );

			location(
				url = "/index.cfm",
				addToken = false
			);

		} catch ( any error ) {

			errorMessage = requestHelper.processError( error );

		}

	}

	include "./login.view.cfm";

</cfscript>
