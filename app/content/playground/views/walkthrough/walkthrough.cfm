<cfscript>

	param name="request.event[ 3 ]" type="string" default="step1";

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

</cfscript>
