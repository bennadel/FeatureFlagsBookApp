<cfscript>

	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	partialHelper = request.ioc.get( "client.main.lib.PartialHelper" );
	utilities = request.ioc.get( "core.lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	config = partialHelper.getConfig( request.user.email );
	features = partialHelper.getFeatures( config );
	users = partialHelper.getUsers( request.user.email );
	companies = partialHelper.getCompanies( users );
	title = "Staging Contexts";

	request.template.title = title;

	include "./overview.view.cfm";

</cfscript>
