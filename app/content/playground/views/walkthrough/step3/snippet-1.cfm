<cfsavecontent variable="code">
<cfoutput>

if ( <mark>features[ "#request.walkthroughFeature.key#" ]</mark> ) {

	// ... <mark>render new rich-text editor</mark> ...

} else {
	
	// ... render old plain-text editor ...

}

</cfoutput>
</cfsavecontent>

<cfoutput><pre class="ui-snippet ui-readable-width"><code>#trim( code )#</code></pre></cfoutput>