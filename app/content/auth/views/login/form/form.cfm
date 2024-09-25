<cfscript>

	authWorkflow = request.ioc.get( "lib.workflow.AuthWorkflow" );
	config = request.ioc.get( "config" );
	requestHelper = request.ioc.get( "lib.RequestHelper" );
	requestMetadata = request.ioc.get( "lib.RequestMetadata" );
	turnstile = request.ioc.get( "lib.turnstile.Turnstile" );
	xsrfService = request.ioc.get( "lib.XsrfService" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="form.submitted" type="boolean" default=false;
	param name="form.email" type="string" default="";
	param name="form[ 'cf-turnstile-response' ]" type="string" default="";
	param name="request.context.redirectTo" type="string" default="";

	request.template.title = "Login";
	errorMessage = "";

	if ( form.submitted && form.email.trim().len() ) {

		try {

			turnstile.testToken( form[ "cf-turnstile-response" ], requestMetadata.getIpAddress() );
			authWorkflow.login( form.email.trim() );
			xsrfService.cycleCookie();

			requestHelper.redirect(
				targetUrl = request.context.redirectTo,
				fallbackUrl = "/index.cfm"
			);

		} catch ( any error ) {

			errorMessage = requestHelper.processError( error );

		}

	}

	include "./form.view.cfm";

</cfscript>
