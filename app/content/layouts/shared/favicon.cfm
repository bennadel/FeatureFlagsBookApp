<cfscript>

	version = request.ioc.get( "staticAssetVersion" );

</cfscript>
<cfoutput>
	<link rel="shortcut icon" type="image/png" href="/assets/favicon@2x.png?version=#encodeForUrl( version )#" />
</cfoutput>
