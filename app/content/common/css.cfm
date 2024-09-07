<cfscript>

	version = request.ioc.get( "staticAssetVersion" );

</cfscript>
<cfoutput>
	<link rel="stylesheet" type="text/css" href="/assets/main.css?version=#encodeForUrl( version )#" />
</cfoutput>
