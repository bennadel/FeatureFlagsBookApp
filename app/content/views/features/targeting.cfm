<cfscript>

	configSerializer = request.ioc.get( "lib.model.config.ConfigSerializer" );
	configValidation = request.ioc.get( "lib.model.config.ConfigValidation" );
	demoTargeting = request.ioc.get( "lib.demo.DemoTargeting" );
	demoUsers = request.ioc.get( "lib.demo.DemoUsers" );
	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	logger = request.ioc.get( "lib.Logger" );
	requestHelper = request.ioc.get( "lib.RequestHelper" );
	utilities = request.ioc.get( "lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.context.featureKey" type="string" default="";
	param name="form.submitted" type="boolean" default=false;
	param name="form.featureData" type="string" default="";

	config = featureWorkflow.getConfig( request.user.email );

	if ( ! config.features.keyExists( request.context.featureKey ) ) {

		configValidation.throwFeatureNotFoundError();

	}

	feature = config.features[ request.context.featureKey ];
	feature.key = utilities.getStructKey( config.features, request.context.featureKey );
	environments = utilities.toEnvironmentsArray( config.environments );

	featureFlags = new lib.client.FeatureFlags()
		.withConfig( config )
		.withLogger( logger )
	;

	request.template.title = "Feature Targeting";

	include "./targeting.view.cfm";

</cfscript>
