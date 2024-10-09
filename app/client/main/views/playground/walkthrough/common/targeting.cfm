<cfscript>

	featureFlags = request.ioc.get( "core.lib.client.FeatureFlags" );
	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	partialHelper = request.ioc.get( "client.main.views.common.lib.PartialHelper" );
	ui = request.ioc.get( "client.common.lib.ViewHelper" );
	utilities = request.ioc.get( "core.lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="attributes.step" type="numeric";
	param name="attributes.highlightAssociation" type="string" default="";

	config = partialHelper.getConfig( request.user.email );
	feature = partialHelper.getFeature( config, request.featureKey );
	environments = partialHelper.getEnvironments( config );
	users = partialHelper.getUsers( request.user.email );
	companies = partialHelper.getCompanies( users );
	results = getResults( config, feature, environments, users );
	journey = getJourney();

	include "./targeting.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the journey steps for the walk-through.
	*/
	private struct function getJourney() {

		return [
			"2": "Initial Feature State",
			"3": "Enable in Development Environment",
			"4": "Solo Testing in Production",
			"5": "Internal Testing in Production",
			"6": "Beta-Testing With Customer",
			"7": "Cautious Roll-Out to 25% of Users",
			"8": "Cautious Roll-Out to 50% of Users",
			"9": "Enable Feature For All Users",
			"10": "Soaking in Production",
			"11": "Time For Your Next Challenge"
		];

	}


	/**
	* I get the results matrix of feature x environments x users.
	*/
	private struct function getResults(
		required struct config,
		required struct feature,
		required array environments,
		required array users
		) {

		var results = {};

		for ( var environment in environments ) {

			results[ environment.key ] = {};

			for ( var user in users ) {

				results[ environment.key ][ user.id ] = featureFlags.debugEvaluation(
					config = config,
					featureKey = feature.key,
					environmentKey = environment.key,
					context = partialHelper.getContext( user ),
					fallbackVariant = "FALLBACK"
				);

			}

		}

		return results;

	}

</cfscript>
