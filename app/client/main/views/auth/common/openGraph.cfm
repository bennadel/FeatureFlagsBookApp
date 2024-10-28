<cfscript>

	config = request.ioc.get( "config" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	title = config.site.name;
	description = "As a companion piece to my feature flags book, this app provides a playground in which readers can get hands-on experience configuring feature flags; and, seeing how changes in configuration affect variant targeting against a set of demo cohorts.";
	siteUrl = config.site.url;
	imageUrl = "#config.site.url#/assets/open-graph-image@2x.png";

	include "./openGraph.view.cfm";

</cfscript>
