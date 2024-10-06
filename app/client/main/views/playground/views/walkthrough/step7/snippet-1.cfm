<cfsavecontent variable="code">
<cfoutput>

{
	"#request.featureKey#": {
		targeting: {
			<mark>production:</mark> {
				resolution: {
					type: "distribution",
					<mark>distribution:</mark> [ <span class="ui-variant-1">50</span>, <span class="ui-variant-2">50</span> ]
				},
				rulesEnabled: true,
				rules: [
					// ... other rules are still in place ...
				]
			}
		}
	}
}

</cfoutput>
</cfsavecontent>

<cfoutput><pre class="ui-snippet"><code>#trim( code )#</code></pre></cfoutput>

