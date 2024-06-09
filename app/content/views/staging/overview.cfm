<cfscript>

	demoConfig = request.ioc.get( "lib.demo.DemoConfig" );
	demoLogger = request.ioc.get( "lib.Logger" );
	demoTargeting = request.ioc.get( "lib.demo.DemoTargeting" );
	demoUsers = request.ioc.get( "lib.demo.DemoUsers" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="url.environmentName" type="string" default="development";

	request.template.title = "Feature Flag Evaluation";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	// TODO: Move all of this logic into a Partial component.

	demoData = {
		config: demoConfig.getConfig(),
		users: demoUsers.getUsers()
	};

	// Eventually, this will be replaced with the user's configuration. But, for the
	// meantime, having the demo data will help me figure out the layout of the view.
	// --
	// Flip some flags on to vary the rendering.
	config = demoTargeting.injectRules( demoData.config );

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

	include "./overview.view.cfm";

</cfscript>
