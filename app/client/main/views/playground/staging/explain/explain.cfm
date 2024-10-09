<cfscript>

	featureFlags = request.ioc.get( "core.lib.client.FeatureFlags" );
	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	partialHelper = request.ioc.get( "client.main.views.common.lib.PartialHelper" );
	utilities = request.ioc.get( "core.lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="url.userID" type="numeric";
	param name="url.featureKey" type="string";
	param name="url.environmentKey" type="string";

	config = partialHelper.getConfig( request.user.email );
	user = partialHelper.getUser( request.user.email, val( url.userID ) );
	feature = partialHelper.getFeature( config, url.featureKey );
	environment = partialHelper.getEnvironment( config, url.environmentKey );
	result = getResult( config, user, feature, environment );
	title = "Variant Allocation Explanation";

	request.template.title = title;
	request.template.video = "staging-explain";

	include "./explain.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the feature targeting result for the given user, feature, environment.
	*/
	private struct function getResult(
		required struct config,
		required struct user,
		required struct feature,
		required struct environment
		) {

		return featureFlags.debugEvaluation(
			config = config,
			featureKey = feature.key,
			environmentKey = environment.key,
			context = partialHelper.getContext( user ),
			fallbackVariant = "FALLBACK"
		);

	}

</cfscript>
