<cfscript>

	configValidation = request.ioc.get( "lib.model.config.ConfigValidation" );
	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "lib.RequestHelper" );
	utilities = request.ioc.get( "lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.context.featureKey" type="string" default="";
	param name="form.submitted" type="boolean" default=false;

	config = featureWorkflow.getConfig( request.user.email );

	if ( ! config.features.keyExists( request.context.featureKey ) ) {

		configValidation.throwFeatureNotFoundError();

	}

	feature = config.features[ request.context.featureKey ];
	feature.key = utilities.getStructKey( config.features, request.context.featureKey );

	errorMessage = "";

	if ( form.submitted ) {

		try {

			config.features.delete( feature.key );

			featureWorkflow.updateConfig(
				email = request.user.email,
				config = config
			);

			location(
				url = "/index.cfm",
				addToken = false
			);

		} catch ( any error ) {

			errorMessage = requestHelper.processError( error );

		}

	}

	request.template.title = "Delete Feature Flag";

	include "./delete.view.cfm";

</cfscript>
