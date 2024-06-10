<cfscript>

	demoConfig = request.ioc.get( "lib.demo.DemoConfig" );
	demoLogger = request.ioc.get( "lib.Logger" );
	demoTargeting = request.ioc.get( "lib.demo.DemoTargeting" );
	demoUsers = request.ioc.get( "lib.demo.DemoUsers" );

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
	// easier to render in the list of features.
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
	// render in the list of features.
	features = config.features
		.keyArray()
		.sort( "textnocase" )
		.map(
			( key ) => {

				return {
					key: key,
					type: config.features[ key ].type,
					description: config.features[ key ].description,
					variants: config.features[ key ].variants,
					environments: config.features[ key ].environments
				};

			}
		)
	;

	featureFlags = new lib.client.FeatureFlags()
		.withConfig( config )
		.withLogger( demoLogger )
	;

	request.template.title = "Welcome";

	include "./welcome.view.cfm";

</cfscript>
