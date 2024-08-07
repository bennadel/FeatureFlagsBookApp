<cfscript>

	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "lib.RequestHelper" );
	utilities = request.ioc.get( "lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="form.featureKey" type="string" default="";
	param name="form.type" type="string" default="boolean";
	param name="form.description" type="string" default="";
	param name="form.defaultSelection" type="numeric" default=1;
	param name="form.variantsRaw" type="array" default=[];
	param name="form.submitted" type="boolean" default=false;

	config = featureWorkflow.getConfig( request.user.email );
	errorMessage = "";

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

			location(
				url = "/index.cfm?event=features.targeting&featureKey=#encodeForUrl( form.featureKey )#",
				addToken = false
			);

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

	request.template.title = "Create New Feature Flag";

	include "./create.view.cfm";

</cfscript>
