<cfsavecontent variable="code">
<cfoutput>

if ( <mark>features[ "#request.featureKey#" ]</mark> ) {

	// ... <span class="ui-variant-2">render new rich-text editor</span> ...

} else {
	
	// ... <span class="ui-variant-1">render old plain-text editor</span> ...

}

</cfoutput>
</cfsavecontent>

<cfoutput><pre class="ui-snippet"><code>#trim( code )#</code></pre></cfoutput>