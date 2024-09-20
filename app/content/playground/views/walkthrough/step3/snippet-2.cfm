<cfsavecontent variable="code">
<cfoutput>

{
	"#request.featureKey#": {
		targeting: {
			<mark>production:</mark> {
				rulesEnabled: true,
				rules: [
					{
						input: <mark>"user.email"</mark>,
						operator: <mark>"IsOneOf"</mark>,
						values: [ <mark>"#encodeForHtml( request.user.email )#"</mark> ],
						resolution: {
							type: "selection",
							<mark>selection: 2</mark>
						}
					}
				]
			}
		}
	}
}

</cfoutput>
</cfsavecontent>

<cfoutput><pre class="ui-snippet ui-readable-width"><code>#trim( code )#</code></pre></cfoutput>

