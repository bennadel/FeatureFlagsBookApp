<cfscript>

	configValidation = request.ioc.get( "core.lib.model.config.ConfigValidation" );
	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "core.lib.RequestHelper" );
	ui = request.ioc.get( "client.common.lib.ViewHelper" );
	utilities = request.ioc.get( "core.lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.context.featureKey" type="string" default="";
	param name="request.context.environmentKey" type="string" default="";
	param name="form.resolutionType" type="string" default="selection";
	param name="form.resolutionSelection" type="numeric" default=1;
	param name="form.resolutionDistribution" type="array" default=[];
	param name="form.resolutionVariant" type="any" default="";
	param name="form.submitted" type="boolean" default=false;

	config = getConfig( request.user.email );
	feature = getFeature( config, request.context.featureKey );
	environment = getEnvironment( config, request.context.environmentKey );
	resolution = feature.targeting[ environment.key ].resolution;
	title = "Default Resolution";
	errorMessage = "";

	request.template.title = title;
	request.template.video = "feature-default-resolution";

	if ( form.submitted ) {

		try {

			// Note: We can store dirty data into the resolution configuration - the
			// validation process will skip-over anything that isn't relevant to the
			// given resolution type.
			config
				.features[ feature.key ]
					.targeting[ environment.key ]
						.resolution = [
							type: form.resolutionType,
							selection: form.resolutionSelection,
							distribution: form.resolutionDistribution,
							variant: form.resolutionVariant
						]
			;

			featureWorkflow.updateConfig(
				email = request.user.email,
				config = config
			);

			requestHelper.goto(
				[
					event: "playground.features.detail.targeting",
					featureKey: feature.key
				],
				"environment-#environment.key#"
			);

		} catch ( any error ) {

			errorMessage = requestHelper.processError( error );

		}

	} else {

		form.resolutionType = resolution.type;

		if ( resolution.type == "selection" ) {

			form.resolutionSelection = resolution.selection;

		} else {

			form.resolutionSelection = 1;

		}

		if ( resolution.type == "distribution" ) {

			form.resolutionDistribution = resolution.distribution;

		} else {

			form.resolutionDistribution = feature.variants.map(
				( _, i ) => {

					return ( ( i == 1 ) ? 100 : 0 );

				}
			);

		}

		if ( resolution.type == "variant" ) {

			switch ( feature.type ) {
				case "string":
					form.resolutionVariant = resolution.variant;
				break;
				default:
					form.resolutionVariant = serializeJson( resolution.variant );
				break;
			}

		} else {

			switch ( feature.type ) {
				case "boolean":
					form.resolutionVariant = false;
				break;
				case "number":
					form.resolutionVariant = 0;
				break;
				default:
					form.resolutionVariant = "";
				break;
			}

		}

	}

	include "./defaultResolution.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

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
