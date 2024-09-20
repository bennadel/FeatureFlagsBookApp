<cfsavecontent variable="code">
<cfoutput>

{
	"#request.featureKey#": {
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
							selection: <span class="variant-2">2</span>
						}
					},
					{
						input: <mark>"user.company.subdomain"</mark>,
						operator: <mark>"IsOneOf"</mark>,
						values: [ <mark>"devteam"</mark> ],
						resolution: {
							type: "selection",
							<mark>selection: <span class="variant-2">2</span></mark>
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

