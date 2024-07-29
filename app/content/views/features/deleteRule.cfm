<cfscript>

	configValidation = request.ioc.get( "lib.model.config.ConfigValidation" );
	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "lib.RequestHelper" );
	utilities = request.ioc.get( "lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.context.featureKey" type="string" default="";
	param name="request.context.environmentKey" type="string" default="";
	param name="request.context.ruleIndex" type="numeric" default=0;
	param name="form.submitted" type="boolean" default=false;

	config = featureWorkflow.getConfig( request.user.email );

	if ( ! config.features.keyExists( request.context.featureKey ) ) {

		configValidation.throwFeatureNotFoundError();

	}

	feature = config.features[ request.context.featureKey ];
	feature.key = utilities.getStructKey( config.features, request.context.featureKey );

	if ( ! feature.targeting.keyExists( request.context.environmentKey ) ) {

		configValidation.throwTargetingNotFoundError();

	}

	targeting = feature.targeting[ request.context.environmentKey ];
	targeting.key = utilities.getStructKey( feature.targeting, request.context.environmentKey );

	rules = targeting.rules;

	if ( ! request.context.ruleIndex || ! rules.isDefined( request.context.ruleIndex ) ) {

		configValidation.throwRuleNotFoundError();

	}

	rule = rules[ request.context.ruleIndex ];
	errorMessage = "";

	if ( form.submitted ) {

		try {

			rules.deleteAt( request.context.ruleIndex );

			featureWorkflow.updateConfig(
				email = request.user.email,
				config = config
			);

			location(
				url = "/index.cfm?event=features.targeting&featureKey=#encodeForUrl( feature.key )###environment-#encodeForUrl( targeting.key )#",
				addToken = false
			);

		} catch ( any error ) {

			errorMessage = requestHelper.processError( error );

		}

	}

	request.template.title = "Delete Rule";

	include "./deleteRule.view.cfm";

</cfscript>
