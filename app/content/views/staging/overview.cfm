<cfscript>

	demoLogger = request.ioc.get( "lib.Logger" );
	demoTargeting = request.ioc.get( "lib.demo.DemoTargeting" );
	demoUsers = request.ioc.get( "lib.demo.DemoUsers" );
	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	utilities = request.ioc.get( "lib.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="url.environmentKey" type="string" default="development";

	request.template.title = "Feature Flag Evaluation";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	// TODO: Move all of this logic into a Partial component.

	demoData = {
		users: demoUsers.getUsers()
	};

	config = featureWorkflow.getConfig( request.user.email );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	// Convert structs to arrays for easier consumption.
	environments = utilities.toEnvironmentsArray( config.environments );
	features = utilities.toFeaturesArray( config.features );

	featureFlags = new lib.client.FeatureFlags()
		.withConfig( config )
		.withLogger( demoLogger )
	;

	if ( ! config.environments.keyExists( url.environmentKey ) ) {

		url.environmentKey = environments
			.first()
			.key
		;

	}

	include "./overview.view.cfm";

</cfscript>
