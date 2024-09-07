<cfscript>

	version = request.ioc.get( "staticAssetVersion" );

</cfscript>
<cfoutput>
	<script type="text/javascript" defer src="/assets/alpine.3.14.1.min.js?version=#encodeForUrl( version )#"></script>
</cfoutput>
