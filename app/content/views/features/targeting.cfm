<cfscript>

	configSerializer = request.ioc.get( "lib.model.config.ConfigSerializer" );
	configValidation = request.ioc.get( "lib.model.config.ConfigValidation" );
	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "lib.RequestHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.context.featureKey" type="string" default="";
	param name="form.submitted" type="boolean" default=false;
	param name="form.featureData" type="string" default="";

	config = featureWorkflow.getConfig( request.user.email );

	if ( ! config.features.keyExists( request.context.featureKey ) ) {

		configValidation.throwFeatureNotFoundError();

	}

	feature = config.features[ request.context.featureKey ];
	errorMessage = "";

	if ( form.submitted ) {

		try {

			newFeature = configSerializer.deserializeFeature( form.featureData );

			featureWorkflow.updateFeature(
				email = request.user.email,
				featureKey = request.context.featureKey,
				feature = newFeature
			);

			location(
				url = "/index.cfm",
				addToken = false
			);

		} catch ( any error ) {

			errorMessage = requestHelper.processError( error );

		}

	} else {

		form.featureData = configSerializer.serializeFeature( feature );

	}

	request.template.title = "Feature Targeting";

	include "./targeting.view.cfm";

</cfscript>
