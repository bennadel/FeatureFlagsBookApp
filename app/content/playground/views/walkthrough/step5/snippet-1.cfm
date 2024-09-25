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
							selection: <span class="ui-variant-2">2</span>
						}
					},
					{
						input: "user.company.subdomain",
						operator: "IsOneOf",
						values: [ "devteam" ],
						resolution: {
							type: "selection",
							selection: <span class="ui-variant-2">2</span>
						}
					},
					{
						input: <mark>"user.company.subdomain"</mark>,
						operator: <mark>"IsOneOf"</mark>,
						values: [ <mark>"dayknight"</mark> ],
						resolution: {
							type: "selection",
							<mark>selection: <span class="ui-variant-2">2</span></mark>
						}
					}
				]
			}
		}
	}
}

</cfoutput>
</cfsavecontent>

<cfoutput><pre class="ui-snippet"><code>#trim( code )#</code></pre></cfoutput>

