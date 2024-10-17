<cfscript>

	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	partialHelper = request.ioc.get( "client.main.views.common.lib.PartialHelper" );
	requestHelper = request.ioc.get( "client.common.lib.RequestHelper" );
	ui = request.ioc.get( "client.common.lib.ViewHelper" );
	utilities = request.ioc.get( "core.lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.context.featureKey" type="string" default="";
	param name="request.context.environmentKey" type="string" default="";
	param name="form.resolutionType" type="string" default="selection";
	param name="form.resolutionSelection" type="numeric" default=1;
	param name="form.resolutionDistribution" type="array" default=[];
	param name="form.resolutionVariant" type="any" default="";
	param name="form.submitted" type="boolean" default=false;

	config = partialHelper.getConfig( request.user.email );
	feature = partialHelper.getFeature( config, request.context.featureKey );
	environment = partialHelper.getEnvironment( config, request.context.environmentKey );
	resolution = feature.targeting[ environment.key ].resolution;
	title = "Default Resolution";
	errorMessage = "";

	request.template.title = title;
	request.template.video = "feature-default-resolution";

	// Process form data.
	if ( form.submitted ) {

		try {

			featureWorkflow.updateDefaultResolution(
				email = request.user.email,
				featureKey = feature.key,
				environmentKey = environment.key,
				// Note: We can store dirty data into the resolution configuration - the
				// underlying validation process will skip-over anything that isn't
				// relevant to the given resolution type.
				resolution = [
					type: form.resolutionType,
					selection: form.resolutionSelection,
					distribution: form.resolutionDistribution,
					variant: form.resolutionVariant
				]
			);

			requestHelper.goto(
				[
					event: "playground.features.detail.targeting",
					featureKey: feature.key
				],
				"environment-#environment.key#"
			);

		} catch ( any error ) {

			errorMessage = requestHelper.processError( error );

		}

	// Initialize form data.
	} else {

		form.resolutionType = resolution.type;

		if ( resolution.type == "selection" ) {

			form.resolutionSelection = resolution.selection;

		} else {

			form.resolutionSelection = 1;

		}

		if ( resolution.type == "distribution" ) {

			form.resolutionDistribution = resolution.distribution;

		} else {

			form.resolutionDistribution = feature.variants.map(
				( _, i ) => {

					return ( ( i == 1 ) ? 100 : 0 );

				}
			);

		}

		if ( resolution.type == "variant" ) {

			switch ( feature.type ) {
				case "string":
					form.resolutionVariant = resolution.variant;
				break;
				default:
					form.resolutionVariant = serializeJson( resolution.variant );
				break;
			}

		} else {

			switch ( feature.type ) {
				case "boolean":
					form.resolutionVariant = false;
				break;
				case "number":
					form.resolutionVariant = 0;
				break;
				default:
					form.resolutionVariant = "";
				break;
			}

		}

	}

	include "./defaultResolution.view.cfm";

</cfscript>
