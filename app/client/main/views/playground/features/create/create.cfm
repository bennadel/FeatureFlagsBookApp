<cfscript>

	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "client.main.lib.RequestHelper" );
	ui = request.ioc.get( "client.main.lib.ViewHelper" );
	utilities = request.ioc.get( "core.lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="form.featureKey" type="string" default="";
	param name="form.type" type="string" default="boolean";
	param name="form.description" type="string" default="";
	param name="form.defaultSelection" type="numeric" default=1;
	param name="form.variantsRaw" type="array" default=[];
	param name="form.submitted" type="boolean" default=false;

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

			featureWorkflow.addFeature(
				email = request.user.email,
				featureKey = form.featureKey,
				type = form.type,
				description = form.description,
				variants = variants,
				defaultSelection = form.defaultSelection
			);

			requestHelper.goto([
				event: "playground.features.detail.targeting",
				featureKey: form.featureKey
			]);

		} catch ( any error ) {

			errorMessage = requestHelper.processError( error );

		}

	} else {

		// For the sake of UI simplicity, we're not going to allow the user to add an
		// open-ended number of variants. Instead, we'll provide a large, fixed number of
		// inputs for them to consume.
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

</cfscript>
