<cfsavecontent variable="code">
<cfoutput>

{
	"#request.walkthroughFeature.key#": {
		targeting: {
			<mark>development:</mark> {
				resolution: {
					type: "selection",
					<mark>selection: 2</mark>
				}
			}
		}
	}
}

</cfoutput>
</cfsavecontent>

<cfoutput><pre class="ui-snippet ui-readable-width"><code>#trim( code )#</code></pre></cfoutput>

