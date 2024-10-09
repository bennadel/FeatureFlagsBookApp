<cfscript>

	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	partialHelper = request.ioc.get( "client.main.views.common.lib.PartialHelper" );
	requestHelper = request.ioc.get( "core.lib.RequestHelper" );
	utilities = request.ioc.get( "core.lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.context.featureKey" type="string" default="";
	param name="form.submitted" type="boolean" default=false;

	config = partialHelper.getConfig( request.user.email );
	feature = partialHelper.getFeature( config, request.context.featureKey );
	title = "Delete Feature Flag";
	errorMessage = "";

	request.template.title = title;

	if ( form.submitted ) {

		try {

			featureWorkflow.deleteFeature(
				email = request.user.email,
				featureKey = feature.key
			);

			requestHelper.goto();

		} catch ( any error ) {

			errorMessage = requestHelper.processError( error );

		}

	}

	include "./delete.view.cfm";

</cfscript>
