<cfscript>

	configValidation = request.ioc.get( "lib.model.config.ConfigValidation" );
	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "lib.RequestHelper" );
	utilities = request.ioc.get( "lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.context.featureKey" type="string" default="";
	param name="request.context.environmentKey" type="string" default="";
	param name="form.resolutionData" type="string" default="";
	param name="form.submitted" type="boolean" default=false;

	partial = getPartial(
		email = request.user.email,
		featureKey = request.context.featureKey,
		environmentKey = request.context.environmentKey
	);

	errorMessage = "";

	if ( form.submitted ) {

		try {

			// Note: We can story dirty data into the config - the validation process will
			// skip-over anything that isn't relevant to the resolution type.
			partial.config
				.features[ partial.feature.key ]
					.targeting[ partial.environment.key ]
						.resolution = deserializeJson( form.resolutionData )
			;

			featureWorkflow.updateConfig(
				email = request.user.email,
				config = partial.config
			);

			location(
				url = "/index.cfm?event=playground.features.targeting&featureKey=#encodeForUrl( partial.feature.key )###environment-#encodeForUrl( partial.environment.key )#",
				addToken = false
			);

		} catch ( any error ) {

			errorMessage = requestHelper.processError( error );

		}

	} else {

		form.resolutionData = serializeJson( partial.resolution );

	}

	request.template.title = partial.title;

	include "./defaultResolution.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the main partial payload for the view.
	*/
	private struct function getPartial(
		required string email,
		required string  featureKey,
		required string  environmentKey
		) {

		var config = getConfig( email );
		var feature = getFeature( config, featureKey );
		var environment = getEnvironment( config, environmentKey );
		var resolution = feature.targeting[ environment.key ].resolution;

		return {
			config: config,
			feature: feature,
			environment: environment,
			resolution: resolution,
			title: "Default Resolution"
		};

	}


	/**
	* I get the config data for the given authenticated user.
	*/
	private struct function getConfig( required string email ) {

		return featureWorkflow.getConfig( email );

	}


	/**
	* I get the environment for the given key.
	*/
	private struct function getEnvironment(
		required struct config,
		required string environmentKey
		) {

		var environments = utilities.toEnvironmentsArray( config.environments );
		var environmentIndex = utilities.indexBy( environments, "key" );

		if ( ! environmentIndex.keyExists( environmentKey ) ) {

			configValidation.throwTargetingNotFoundError();

		}

		return environmentIndex[ environmentKey ];

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
