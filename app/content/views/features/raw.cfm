<cfscript>

	configSerializer = request.ioc.get( "lib.model.config.ConfigSerializer" );
	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "lib.RequestHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="form.submitted" type="boolean" default=false;
	param name="form.data" type="string" default="";

	config = featureWorkflow.getConfig( request.user.email );
	errorMessage = "";

	if ( form.submitted ) {

		try {

			newConfig = configSerializer.deserializeConfig( form.data.trim() );

			featureWorkflow.updateConfig(
				email = request.user.email,
				config = newConfig
			);

			location(
				url = "/index.cfm",
				addToken = false
			);

		} catch ( any error ) {

			errorMessage = requestHelper.processError( error );

		}

	} else {

		form.data = configSerializer.serializeConfig( config );

	}

	request.template.title = "Raw Configuration Access";

	include "./raw.view.cfm";

</cfscript>
