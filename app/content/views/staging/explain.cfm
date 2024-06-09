<cfscript>

	demoConfig = request.ioc.get( "lib.demo.DemoConfig" );
	demoLogger = request.ioc.get( "lib.Logger" );
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

	result = featureFlags.debugEvaluation(
		feature = url.featureName,
		environment = url.environmentName,
		context = demoUsers.getContext( demoUser ),
		fallbackVariant = "FALLBACK"
	);

	include "./explain.view.cfm";

</cfscript>
