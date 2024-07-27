<cfscript>

	configValidation = request.ioc.get( "lib.model.config.ConfigValidation" );
	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "lib.RequestHelper" );
	utilities = request.ioc.get( "lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.context.featureKey" type="string" default="";
	param name="request.context.environmentKey" type="string" default="";
	param name="form.rulesEnabled" type="boolean" default=false;
	param name="form.submitted" type="boolean" default=false;

	config = featureWorkflow.getConfig( request.user.email );

	if ( ! config.features.keyExists( request.context.featureKey ) ) {

		configValidation.throwFeatureNotFoundError();

	}

	feature = config.features[ request.context.featureKey ];
	feature.key = utilities.getStructKey( config.features, request.context.featureKey );

	if ( ! feature.targeting.keyExists( request.context.environmentKey ) ) {

		configValidation.throwTargetingNotFoundError();

	}

	targeting = feature.targeting[ request.context.environmentKey ];
	targeting.key = utilities.getStructKey( feature.targeting, request.context.environmentKey );

	errorMessage = "";

	if ( form.submitted ) {

		try {

			targeting.rulesEnabled = !! form.rulesEnabled;

			featureWorkflow.updateConfig(
				email = request.user.email,
				config = config
			);

			location(
				url = "/index.cfm?event=features.targeting&featureKey=#encodeForUrl( feature.key )#",
				addToken = false
			);

		} catch ( any error ) {

			errorMessage = requestHelper.processError( error );

		}

	} else {

		form.rulesEnabled = targeting.rulesEnabled;

	}

	request.template.title = "Rules Enabled";

	include "./rulesEnabled.view.cfm";

</cfscript>
