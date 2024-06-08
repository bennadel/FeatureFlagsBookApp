<cfscript>

	demoLogger = request.ioc.get( "lib.Logger" );
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
		config: request.ioc.get( "lib.demo.DemoConfig" ).getConfig(),
		users: request.ioc.get( "lib.demo.DemoUsers" ).getUsers()
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
	config = demoData.config;

	// Flip some flags on to vary the rendering.
	config.features[ "operations-request-rate-limit" ].environments.development.resolution = {
		type: "variant",
		variant: 100
	};
	config.features[ "product-TICKET-111-reporting" ].environments.development.resolution = {
		type: "Distribution",
		distribution: [ 50, 50 ]
	};
	config.features[ "product-TICKET-222-2fa" ].environments.production.resolution = {
		type: "Selection",
		selection: 2
	};
	config.features[ "product-TICKET-444-homepage-sql-performance" ].environments.production.resolution = {
		type: "Distribution",
		distribution: [ 95, 5 ]
	};
	config.features[ "product-TICKET-444-homepage-sql-performance" ].environments.development.rulesEnabled = true;
	config.features[ "product-TICKET-444-homepage-sql-performance" ].environments.development.rules.append({
		operator: "IsOneOf",
		input: "user.company.subdomain",
		values: [ "innovatek", "starcorp" ],
		resolution: {
			type: "Selection",
			selection: 2
		}
	});
	config.features[ "product-TICKET-555-discount-pricing" ].environments.production.rulesEnabled = true;
	config.features[ "product-TICKET-555-discount-pricing" ].environments.production.rules.append({
		operator: "IsOneOf",
		input: "user.groups.influencer",
		values: [ true ],
		resolution: {
			type: "Selection",
			selection: 2
		}
	});

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	featureFlags = new lib.client.FeatureFlags()
		.withConfig( config )
		.withLogger( demoLogger )
	;

	demoUser = userIndex[ url.userID ];

	userContext = [
		"key": demoUser.id,
		"user.id": demoUser.id,
		"user.email": demoUser.email,
		"user.role": demoUser.role,
		"user.company.id": demoUser.company.id,
		"user.company.subdomain": demoUser.company.subdomain,
		"user.company.fortune100": demoUser.company.fortune100,
		"user.company.fortune500": demoUser.company.fortune500,
		"user.groups.betaTester": demoUser.groups.betaTester,
		"user.groups.influencer": demoUser.groups.influencer
	];

	result = featureFlags.debugEvaluation(
		feature = url.featureName,
		environment = url.environmentName,
		context = userContext,
		fallbackVariant = "FALLBACK"
	);

	include "./explain.view.cfm";

</cfscript>
