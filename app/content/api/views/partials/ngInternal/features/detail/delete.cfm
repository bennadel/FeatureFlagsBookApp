<cfscript>

	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	utilities = request.ioc.get( "lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="url.featureKey" type="string";

	// TODO: Move all of this logic into a Partial component.
	request.template.primaryContent = getPartial(
		email = request.user.email,
		featureKey = url.featureKey.trim()
	);

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the main partial payload for the view.
	*/
	private struct function getPartial(
		required string email,
		required string featureKey
		) {

		var config = getConfig( email );
		var feature = getFeature( config, featureKey );

		return {
			feature: feature
		};

	}


	/**
	* I get the config data for the given authenticated user.
	*/
	private struct function getConfig( required string email ) {

		return featureWorkflow.getConfig( email );

	}


	/**
	* I get the feature for the given config.
	*/
	private struct function getFeature(
		required struct config,
		required string featureKey
		) {

		var features = utilities.toFeaturesArray( config.features );
		var featureIndex = utilities.indexBy( features, "key" );

		if ( ! featureIndex.keyExists( featureKey ) ) {

			// Todo: Throw a more specific error?
			throw(
				type = "App.NotFound",
				message = "Feature flag not found."
			);

		}

		return featureIndex[ featureKey ];

	}

</cfscript>
