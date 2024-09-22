<cfsavecontent variable="code">
<cfoutput>

{
	"#request.featureKey#": {
		targeting: {
			<mark>development:</mark> {
				resolution: {
					type: "selection",
					<mark>selection: <span class="u-variant-2">2</span></mark>
				}
			}
		}
	}
}

</cfoutput>
</cfsavecontent>

<cfoutput><pre class="ui-snippet"><code>#trim( code )#</code></pre></cfoutput>

