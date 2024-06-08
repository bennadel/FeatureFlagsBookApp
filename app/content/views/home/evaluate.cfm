<cfscript>

	demoLogger = request.ioc.get( "Logger" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="url.environmentName" type="string" default="development";

	request.template.title = "Feature Flag Evaluation";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	// TODO: Move all of this logic into a Partial component.

	demoData = {
		config: request.ioc.get( "lib.demo.DemoConfig" ).getConfig(),
		users: request.ioc.get( "lib.demo.DemoUsers" ).getUsers()
	};

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
	// config.features[ "product-TICKET-444-homepage-sql-performance" ].environments.production.rulesEnabled = true;
	// config.features[ "product-TICKET-444-homepage-sql-performance" ].environments.production.rules.append({
	// 	operator: "IsOneOf",
	// 	input: "user.company.subdomain",
	// 	values: [ "innovatek", "starcorp" ],
	// 	resolution: {
	// 		type: "Selection",
	// 		selection: 2
	// 	}
	// });
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

	// The environments are stored by-key. Let's convert them to an array to make it
	// easier to render in the evaluator.
	// --
	// Note: I'm depending on the fact that the environments are stored as an ordered-
	// struct; and therefore, the keys are returned in the same order in which they were
	// defined (which maps the logical progression of code through a deployment).
	environments = config.environments
		.keyArray()
		.map(
			( key ) => {

				return {
					key: key,
					name:  config.environments[ key ].name,
					description:  config.environments[ key ].description
				};

			}
		)
	;

	// The features are stored by-key. Let's convert them to an array to make it easier to
	// render in the evaluator.
	features = config.features
		.keyArray()
		.sort( "textnocase" )
		.map(
			( key ) => {

				return {
					key: key,
					type: config.features[ key ].type,
					description: config.features[ key ].description,
					variants: config.features[ key ].variants
				};

			}
		)
	;

	featureFlags = new lib.client.FeatureFlags()
		.withConfig( config )
		.withLogger( demoLogger )
	;


	if ( ! config.environments.keyExists( url.environmentName ) ) {

		url.environmentName = environments
			.first()
			.key
		;

	}

	include "./evaluate.view.cfm";

</cfscript>
