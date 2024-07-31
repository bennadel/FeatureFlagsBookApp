<cfscript>

	demoLogger = request.ioc.get( "lib.Logger" );
	demoTargeting = request.ioc.get( "lib.demo.DemoTargeting" );
	demoUsers = request.ioc.get( "lib.demo.DemoUsers" );
	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	utilities = request.ioc.get( "lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="url.userID" type="numeric";
	param name="url.featureKey" type="string";
	param name="url.environmentKey" type="string";
	param name="url.from" type="string" default="staging";

	request.template.title = "Explain Evaluation";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	// TODO: Move all of this logic into a Partial component.

	demoData = {
		users: demoUsers.getUsers( request.user.email )
	};

	userIndex = utilities.indexBy( demoData.users, "id" );

	if ( ! userIndex.keyExists( url.userID ) ) {

		location(
			url = "/index.cfm",
			addToken = false
		);

	}

	config = featureWorkflow.getConfig( request.user.email );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	featureFlags = new lib.client.FeatureFlags()
		.withConfig( config )
		.withLogger( demoLogger )
	;

	demoUser = userIndex[ url.userID ];

	result = featureFlags.debugEvaluation(
		featureKey = url.featureKey,
		environmentKey = url.environmentKey,
		context = demoTargeting.getContext( demoUser ),
		fallbackVariant = "FALLBACK"
	);

	include "./explain.view.cfm";

</cfscript>
