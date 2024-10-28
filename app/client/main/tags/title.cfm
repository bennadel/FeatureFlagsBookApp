<cfscript>

	config = request.ioc.get( "config" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.template.title" type="string";

	siteName = config.site.name;

	include "./title.view.cfm";

</cfscript>
