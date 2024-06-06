<cfscript>

	demoConfig = request.ioc.get( "lib.demo.DemoConfig" );
	demoLogger = request.ioc.get( "Logger" );
	demoUsers = request.ioc.get( "lib.demo.DemoUsers" ).getUsers();

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="url.environmentName" type="string" default="development";

	request.template.title = "Feature Flag Evaluation";

	// Eventually, this will be replaced with the user's configuration. But, for the
	// meantime, having the demo data will help me figure out the layout of the view.
	config = demoConfig.getConfig();






	config.features[ "operations-request-rate-limit" ].environments.development.resolution = {
		type: "variant",
		variant: 100
	};

	config.features[ "product-TICKET-444-homepage-sql-performance" ].environments.production.rulesEnabled = true;
	config.features[ "product-TICKET-444-homepage-sql-performance" ].environments.production.rules.append({
		operator: "IsOneOf",
		input: "user.company.subdomain",
		values: [ "innovatek", "starcorp" ],
		resolution: {
			type: "Selection",
			selection: 2
		}
	});

	config.features[ "product-TICKET-222-2fa" ].environments.production.resolution = {
		type: "Selection",
		selection: 2
	};


	config.features[ "product-TICKET-111-reporting" ].environments.development.resolution = {
		type: "Distribution",
		distribution: [ 50, 50 ]
	};




	demoEnvironments = [];

	for ( key in config.environments ) {

		demoEnvironments.append({
			key: key,
			name:  config.environments[ key ].name,
			description:  config.environments[ key ].description
		});

	}

	demoFeatureFlags = [];

	for ( key in config.features ) {

		demoFeatureFlags.append({
			key: key,
			type: config.features[ key ].type,
			variants: config.features[ key ].variants
		});

	}


	featureFlags = new lib.client.FeatureFlags()
		.withConfig( config )
		.withLogger( demoLogger )
	;
	environmentName = url.environmentName;

	include "./evaluate.view.cfm";

</cfscript>
