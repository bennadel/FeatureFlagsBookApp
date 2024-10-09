<cfscript>

	partialHelper = request.ioc.get( "client.main.views.common.lib.PartialHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	config = partialHelper.getConfig( request.user.email );
	title = "Raw JSON Data";

	request.template.title = title;

	include "./json.view.cfm";

</cfscript>
