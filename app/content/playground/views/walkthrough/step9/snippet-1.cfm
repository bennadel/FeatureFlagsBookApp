<cfsavecontent variable="code">
<cfoutput>

{
	"#request.walkthroughFeature.key#": {
		targeting: {
			<mark>production:</mark> {
				<mark>resolution:</mark> {
					type: <mark>"selection"</mark>,
					<mark>selection: 2</mark>
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

