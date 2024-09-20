<cfsavecontent variable="code">
<cfoutput>

{
	"#request.walkthroughFeature.key#": {
		targeting: {
			<mark>production:</mark> {
				rulesEnabled: true,
				rules: [
					{
						input: "user.email",
						operator: "IsOneOf",
						values: [ "#encodeForHtml( request.user.email )#" ],
						resolution: {
							type: "selection",
							selection: 2
						}
					},
					{
						input: <mark>"user.company.subdomain"</mark>,
						operator: <mark>"IsOneOf"</mark>,
						values: [ <mark>"devteam"</mark> ],
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

