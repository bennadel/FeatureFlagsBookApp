<cfscript>

	demoConfig = request.ioc.get( "lib.demo.DemoConfig" );
	demoLogger = request.ioc.get( "lib.Logger" );
	demoTargeting = request.ioc.get( "lib.demo.DemoTargeting" );
	demoUsers = request.ioc.get( "lib.demo.DemoUsers" );
	utilities = request.ioc.get( "lib.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="url.userID" type="numeric";
	param name="url.featureName" type="string";
	param name="url.environmentName" type="string";

	request.template.title = "Explain Evaluation";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	// TODO: Move all of this logic into a Partial component.

	demoData = {
		config: demoConfig.getConfig(),
		users: demoUsers.getUsers()
	};

	userIndex = utilities.indexBy( demoData.users, "id" );

	if ( ! userIndex.keyExists( url.userID ) ) {

		location(
			url = "/index.cfm",
			addToken = false
		);

	}

	// Eventually, this will be replaced with the user's configuration. But, for the
	// meantime, having the demo data will help me figure out the layout of the view.
	config = demoTargeting.injectRules( demoData.config );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	featureFlags = new lib.client.FeatureFlags()
		.withConfig( config )
		.withLogger( demoLogger )
	;

	demoUser = userIndex[ url.userID ];

	result = featureFlags.debugEvaluation(
		feature = url.featureName,
		environment = url.environmentName,
		context = demoTargeting.getContext( demoUser ),
		fallbackVariant = "FALLBACK"
	);

	include "./explain.view.cfm";

</cfscript>
