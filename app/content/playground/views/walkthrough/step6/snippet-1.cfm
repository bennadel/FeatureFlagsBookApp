<cfsavecontent variable="code">
<cfoutput>

{
	"#request.featureKey#": {
		targeting: {
			<mark>production:</mark> {
				<mark>resolution:</mark> {
					type: "distribution",
					<mark>distribution:</mark> [ <span class="variant-1">75</span>, <span class="variant-2">25</span> ]
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

<cfoutput><pre class="ui-snippet ui-readable-width"><code>#trim( code )#</code></pre></cfoutput>

