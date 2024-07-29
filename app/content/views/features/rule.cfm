<cfscript>

	configValidation = request.ioc.get( "lib.model.config.ConfigValidation" );
	demoTargeting = request.ioc.get( "lib.demo.DemoTargeting" );
	demoUsers = request.ioc.get( "lib.demo.DemoUsers" );
	featureWorkflow = request.ioc.get( "lib.workflow.FeatureWorkflow" );
	requestHelper = request.ioc.get( "lib.RequestHelper" );
	utilities = request.ioc.get( "lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.context.featureKey" type="string" default="";
	param name="request.context.environmentKey" type="string" default="";
	param name="request.context.ruleIndex" type="numeric" default=0;
	param name="form.ruleData" type="string" default="";
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

	// Editing an existing rule.
	if ( request.context.ruleIndex && rules.isDefined( request.context.ruleIndex ) ) {

		rule = rules[ request.context.ruleIndex ];

	// Adding a new rule.
	} else {

		// Force index to be zero as a safe-guard.
		request.context.ruleIndex = 0;

		rule = [
			operator: "IsOneOf",
			input: "user.email",
			values: [],
			resolution: [
				type: "selection",
				selection: 1
			]
		];

	}

	errorMessage = "";

	if ( form.submitted ) {

		try {

			if ( request.context.ruleIndex ) {

				rules[ request.context.ruleIndex ] = deserializeJson( form.ruleData );

			} else {

				rules.append( deserializeJson( form.ruleData ) );

			}

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

	} else {

		form.ruleData = serializeJson( rule );

	}

	datalists = demoTargeting.getDatalists( demoUsers.getUsers() );

	request.template.title = "Rule";

	include "./rule.view.cfm";

</cfscript>
