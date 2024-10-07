<cfsavecontent variable="code">
<cfoutput>

{
	"#request.featureKey#": {
		targeting: {
			<mark>production:</mark> {
				<mark>resolution:</mark> {
					type: <mark>"selection"</mark>,
					<mark>selection: <span class="ui-variant-2">2</span></mark>
				},
				rulesEnabled: false,
				rules: []
			}
		}
	}
}

</cfoutput>
</cfsavecontent>

<cfoutput><pre class="ui-snippet"><code>#trim( code )#</code></pre></cfoutput>

