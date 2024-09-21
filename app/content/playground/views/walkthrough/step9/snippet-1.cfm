<cfsavecontent variable="code">
<cfoutput>

{
	"#request.featureKey#": {
		targeting: {
			<mark>production:</mark> {
				<mark>resolution:</mark> {
					type: <mark>"selection"</mark>,
					<mark>selection: <span class="u-variant-2">2</span></mark>
				},
				rulesEnabled: false,
				rules: []
			}
		}
	}
}

</cfoutput>
</cfsavecontent>

<cfoutput><pre class="ui-snippet ui-readable-width"><code>#trim( code )#</code></pre></cfoutput>

