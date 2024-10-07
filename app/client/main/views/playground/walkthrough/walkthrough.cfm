<cfscript>

	demoConfig = request.ioc.get( "core.lib.demo.DemoConfig" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.event[ 3 ]" type="string" default="step1";

	// Every step in this module will build on top of the previous step, incrementally
	// changing the features. However, in order to make sure that the steps are in the
	// expected state, every step is going to reset the feature to the expected state on
	// load. The following structure provides the basis on which each step will build.
	request.featureKey = "product-TICKET-919-rich-text-editor";
	request.feature = demoConfig.buildFeature(
		type = "boolean",
		description = "This feature enables the use of a new rich text editor for long-form content. It replaces the current plain text inputs with an editable content area powered by the Quill.js library.",
		variants = [ false, true ]
	);

	request.template.activeNavItem = "features";

	switch ( request.event[ 3 ] ) {
		case "step1":
			cfmodule( template = "./step1/step1.cfm" );
		break;
		case "step2":
			cfmodule( template = "./step2/step2.cfm" );
		break;
		case "step3":
			cfmodule( template = "./step3/step3.cfm" );
		break;
		case "step4":
			cfmodule( template = "./step4/step4.cfm" );
		break;
		case "step5":
			cfmodule( template = "./step5/step5.cfm" );
		break;
		case "step6":
			cfmodule( template = "./step6/step6.cfm" );
		break;
		case "step6b":
			cfmodule( template = "./step6b/step6b.cfm" );
		break;
		case "step6c":
			cfmodule( template = "./step6c/step6c.cfm" );
		break;
		case "step7":
			cfmodule( template = "./step7/step7.cfm" );
		break;
		case "step8":
			cfmodule( template = "./step8/step8.cfm" );
		break;
		case "step9":
			cfmodule( template = "./step9/step9.cfm" );
		break;
		case "step10":
			cfmodule( template = "./step10/step10.cfm" );
		break;
		case "step11":
			cfmodule( template = "./step11/step11.cfm" );
		break;
		default:
			throw(
				type = "App.Routing.Playground.Walkthrough.InvalidEvent",
				message = "Unknown routing event."
			);
		break;
	}

	cfmodule( template = "./common/layout.cfm" );

</cfscript>
