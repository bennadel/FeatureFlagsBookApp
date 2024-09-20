<cfsavecontent variable="code">
<cfoutput>

{
	"#request.walkthroughFeature.key#": {
		targeting: {
			<mark>production:</mark> {
				resolution: {
					type: "distribution",
					<mark>distribution:</mark> [ <mark>0</mark>, <mark>100</mark> ]
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

