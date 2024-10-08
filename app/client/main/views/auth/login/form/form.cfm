<cfscript>

	authWorkflow = request.ioc.get( "core.lib.workflow.AuthWorkflow" );
	config = request.ioc.get( "config" );
	requestHelper = request.ioc.get( "core.lib.RequestHelper" );
	requestMetadata = request.ioc.get( "core.lib.RequestMetadata" );
	turnstile = request.ioc.get( "core.lib.turnstile.Turnstile" );
	xsrfService = request.ioc.get( "core.lib.XsrfService" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="form.submitted" type="boolean" default=false;
	param name="form.email" type="string" default="";
	param name="form[ 'cf-turnstile-response' ]" type="string" default="";
	param name="request.context.redirectTo" type="string" default="";

	title = "Login";
	errorMessage = "";

	request.template.title = title;

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
