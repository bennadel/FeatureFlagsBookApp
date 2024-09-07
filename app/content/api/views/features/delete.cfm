<cfscript>

	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "lib.RequestHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="form.featureKey" type="string";

	requestHelper.assertHttpPost();

	featureWorkflow.deleteFeature(
		email = request.user.email,
		featureKey = form.featureKey
	);

</cfscript>
