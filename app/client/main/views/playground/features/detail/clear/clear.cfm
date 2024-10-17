<cfscript>

	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	partialHelper = request.ioc.get( "client.main.lib.PartialHelper" );
	requestHelper = request.ioc.get( "client.main.lib.RequestHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.context.featureKey" type="string" default="";
	param name="form.submitted" type="boolean" default=false;

	config = partialHelper.getConfig( request.user.email );
	feature = partialHelper.getFeature( config, request.context.featureKey );
	environments = partialHelper.getEnvironments( config );
	title = "Clear Feature Flag Rules";
	errorMessage = "";

	request.template.title = title;
	request.template.video = "feature-clear";

	if ( form.submitted ) {

		try {

			featureWorkflow.clearFeature(
				email = request.user.email,
				featureKey = feature.key
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

</cfscript>
