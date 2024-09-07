<cfscript>

	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "lib.RequestHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="form.submitted" type="boolean" default=false;

	config = featureWorkflow.getConfig( request.user.email );
	errorMessage = "";

	if ( form.submitted ) {

		try {

			featureWorkflow.clearConfig( request.user.email );

			location(
				url = "/index.cfm",
				addToken = false
			);

		} catch ( any error ) {

			errorMessage = requestHelper.processError( error );

		}

	}

	request.template.title = "Remove Feature Flag Rules";

	include "./clear.view.cfm";

</cfscript>
