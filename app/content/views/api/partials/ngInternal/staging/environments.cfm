<cfscript>

	demoUsers = request.ioc.get( "lib.demo.DemoUsers" );
	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	utilities = request.ioc.get( "lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	// TODO: Move all of this logic into a Partial component.
	request.template.primaryContent = getPartial( request.user.email );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the main partial payload for the view.
	*/
	private struct function getPartial( required string email ) {

		var config = featureWorkflow.getConfig( email );
		var users = demoUsers.getUsers( email );
		var environments = getEnvironments( config );

		return {
			environments: environments,
			users: users
		};

	}


	/**
	* I get the environments for the given config.
	*/
	private array function getEnvironments( required struct config ) {

		return utilities.toEnvironmentsArray( config.environments );

	}


	/**
	* I get the features for the given config.
	*/
	private array function getFeatures( required struct config ) {

		return utilities.toFeaturesArray( config.features );

	}

</cfscript>
