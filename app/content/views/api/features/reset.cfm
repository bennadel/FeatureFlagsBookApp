<cfscript>

	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "lib.RequestHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	requestHelper.assertHttpPost();

	featureWorkflow.resetConfig( request.user.email );

</cfscript>
