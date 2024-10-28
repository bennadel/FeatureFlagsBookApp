<cfoutput>

	<!--- Core Open Graph tags. --->
	<meta property="og:title" content="#encodeForHtmlAttribute( title )#" />
	<meta property="og:description" content="#encodeForHtmlAttribute( description )#" />
	<meta property="og:url" content="#encodeForHtmlAttribute( siteUrl )#" />
	<meta property="og:image" content="#encodeForHtmlAttribute( imageUrl )#" />
	<meta property="og:type" content="website" />

	<!--- Twitter Card tags. --->
	<meta name="twitter:card" content="summary_large_image" />
	<meta name="twitter:title" content="#encodeForHtmlAttribute( title )#" />
	<meta name="twitter:description" content="#encodeForHtmlAttribute( description )#" />
	<meta name="twitter:image" content="#encodeForHtmlAttribute( imageUrl )#" />

</cfoutput>
