<cfscript>

	configValidation = request.ioc.get( "core.lib.model.config.ConfigValidation" );
	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "core.lib.RequestHelper" );
	utilities = request.ioc.get( "core.lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.context.featureKey" type="string" default="";
	param name="form.submitted" type="boolean" default=false;

	config = getConfig( request.user.email );
	feature = getFeature( config, request.context.featureKey );
	environments = getEnvironments( config );
	title = "Clear Feature Flag Rules";
	errorMessage = "";

	request.template.title = title;
	request.template.video = "feature-clear";

	if ( form.submitted ) {

		try {

			for ( environment in environments ) {

				config
					.features[ feature.key ]
						.targeting[ environment.key ]
							.rulesEnabled = false
				;
				config
					.features[ feature.key ]
						.targeting[ environment.key ]
							.rules = []
				;

			}

			featureWorkflow.updateConfig(
				email = request.user.email,
				config = config
			);

			requestHelper.goto([
				event: "playground.features.detail.targeting",
				featureKey: feature.key
			]);

		} catch ( any error ) {

			errorMessage = requestHelper.processError( error );

		}

	}

	include "./clear.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the config data for the given authenticated user.
	*/
	private struct function getConfig( required string email ) {

		return featureWorkflow.getConfig( email );

	}


	/**
	* I get the environments for the given config.
	*/
	private array function getEnvironments( required struct config ) {

		return utilities.toEnvironmentsArray( config.environments );

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
