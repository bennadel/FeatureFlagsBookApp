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
					<mark class="ui-revert">{</mark>
						<mark class="ui-revert">input: "user.company.subdomain",</mark>
						<mark class="ui-revert">operator: "IsOneOf",</mark>
						<mark class="ui-revert">values: [ "dayknight" ],</mark>
						<mark class="ui-revert">resolution: {</mark>
							<mark class="ui-revert">type: "selection",</mark>
							<mark class="ui-revert">selection: 2</mark>
						<mark class="ui-revert">}</mark>
					<mark class="ui-revert">}</mark>
				]
			}
		}
	}
}

</cfoutput>
</cfsavecontent>

<cfoutput><pre class="ui-snippet"><code>#trim( code )#</code></pre></cfoutput>

