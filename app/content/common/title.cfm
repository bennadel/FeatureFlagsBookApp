<cfscript>

	config = request.ioc.get( "config" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.template" type="struct";
	param name="request.template.title" type="string";

	siteName = config.site.name;

</cfscript>
<cfoutput>
	<title>
		#encodeForHtml( request.template.title )#

		<!--- Don't double-up on site title. --->
		<cfif ( request.template.title != siteName )>
			&mdash; #encodeForHtml( siteName )#
		</cfif>
	</title>
</cfoutput>
