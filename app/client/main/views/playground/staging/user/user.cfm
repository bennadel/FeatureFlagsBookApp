<cfscript>

	featureFlags = request.ioc.get( "core.lib.client.FeatureFlags" );
	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	partialHelper = request.ioc.get( "client.main.views.common.lib.PartialHelper" );
	utilities = request.ioc.get( "core.lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="url.userID" type="numeric";

	config = partialHelper.getConfig( request.user.email );
	user = partialHelper.getUser( request.user.email, val( url.userID ) );
	context = partialHelper.getContext( user );
	features = partialHelper.getFeatures( config );
	environments = partialHelper.getEnvironments( config );
	breakdown = getBreakdown( config, user, features, environments );
	title = user.name;

	request.template.title = title;
	request.template.video = "staging-user";

	include "./user.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the variant breakdown for the given user.
	*/
	private struct function getBreakdown(
		required struct config,
		required struct user,
		required array features,
		required array environments,
		string fallbackVariant = "FALLBACK"
		) {

		var breakdown = [:];

		for ( var feature in features ) {

			breakdown[ feature.key ] = [:];
			
			for ( var environment in environments ) {

				var result = featureFlags.debugEvaluation(
					config = config,
					featureKey = feature.key,
					environmentKey = environment.key,
					context = partialHelper.getContext( user ),
					fallbackVariant = fallbackVariant
				);

				breakdown[ feature.key ][ environment.key ] = [
					variantIndex: result.variantIndex,
					variant: result.variant,
					matchingRuleIndex: result.matchingRuleIndex
				];

			}

		}

		return breakdown;

	}

</cfscript>
