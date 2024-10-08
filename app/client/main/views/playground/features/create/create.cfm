<cfscript>

	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "core.lib.RequestHelper" );
	ui = request.ioc.get( "client.common.lib.ViewHelper" );
	utilities = request.ioc.get( "core.lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="form.featureKey" type="string" default="";
	param name="form.type" type="string" default="boolean";
	param name="form.description" type="string" default="";
	param name="form.defaultSelection" type="numeric" default=1;
	param name="form.variantsRaw" type="array" default=[];
	param name="form.submitted" type="boolean" default=false;

	config = getConfig( request.user.email );
	title = "Create New Feature Flag";
	errorMessage = "";

	request.template.title = title;
	request.template.video = "features-create";

	if ( form.submitted ) {

		try {

			form.featureKey = form.featureKey.trim();
			form.description = form.description.trim();
			form.variantsRaw = form.variantsRaw.map(
				( value ) => {

					return value.trim();

				}
			);

			variants = form.variantsRaw.filter(
				( value ) => {

					return value.len();

				}
			);

			form.defaultSelection = min( variants.len(), form.defaultSelection );

			config.features[ form.featureKey ] = [
				type: form.type,
				description: form.description,
				variants: variants,
				defaultSelection: form.defaultSelection,
				targeting: config.environments.map(
					( environmentKey ) => {

						return {
							resolution: [
								type: "selection",
								selection: form.defaultSelection
							],
							rulesEnabled: false,
							rules: []
						};

					}
				)
			];

			featureWorkflow.updateConfig(
				email = request.user.email,
				config = config
			);
			requestHelper.goto([
				event: "playground.features.detail.targeting",
				featureKey: form.featureKey
			]);

		} catch ( any error ) {

			errorMessage = requestHelper.processError( error );

		}

	} else {

		form.variantsRaw = [
			"false",
			"true",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			""
		];

	}

	include "./create.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the config data for the given authenticated user.
	*/
	private struct function getConfig( required string email ) {

		return featureWorkflow.getConfig( email );

	}

</cfscript>
