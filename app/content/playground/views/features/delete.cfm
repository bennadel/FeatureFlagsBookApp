<cfscript>

	configValidation = request.ioc.get( "lib.model.config.ConfigValidation" );
	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "lib.RequestHelper" );
	utilities = request.ioc.get( "lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.context.featureKey" type="string" default="";
	param name="form.submitted" type="boolean" default=false;

	partial = getPartial(
		email = request.user.email,
		featureKey = request.context.featureKey
	);

	errorMessage = "";

	if ( form.submitted ) {

		try {

			partial.config.features.delete( partial.feature.key );

			featureWorkflow.updateConfig(
				email = request.user.email,
				config = partial.config
			);

			requestHelper.goto();

		} catch ( any error ) {

			errorMessage = requestHelper.processError( error );

		}

	}

	request.template.title = partial.title;

	include "./delete.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the main partial payload for the view.
	*/
	private struct function getPartial(
		required string email,
		required string  featureKey
		) {

		var config = getConfig( email );
		var feature = getFeature( config, featureKey );

		return {
			config: config,
			feature: feature,
			title: "Delete Feature Flag"
		};

	}


	/**
	* I get the config data for the given authenticated user.
	*/
	private struct function getConfig( required string email ) {

		return featureWorkflow.getConfig( email );

	}


	/**
	* I get the feature for the given key.
	*/
	private struct function getFeature(
		required struct config,
		required string featureKey
		) {

		var features = utilities.toFeaturesArray( config.features );
		var featureIndex = utilities.indexBy( features, "key" );

		if ( ! featureIndex.keyExists( featureKey ) ) {

			configValidation.throwFeatureNotFoundError();

		}

		return featureIndex[ featureKey ];

	}

</cfscript>
