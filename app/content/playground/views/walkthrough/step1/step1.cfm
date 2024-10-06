<cfscript>

	utilities = request.ioc.get( "core.lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	title = request.template.title = "Feature Flag Walk-Through";

	include "./step1.view.cfm";

</cfscript>
