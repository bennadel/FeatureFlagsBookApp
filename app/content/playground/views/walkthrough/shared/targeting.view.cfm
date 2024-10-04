<cfif attributes.highlightAssociation.len()>
	<cfoutput>
		<style type="text/css">

			[m-23jyxr].states span {
				opacity: 0.3 ;
			}
			[m-23jyxr].states span[ data-association = "#attributes.highlightAssociation#" ] {
				animation: m-23jyxr-pulsate 2.2s infinite ease-in-out ;
				opacity: 1.0 ;
			}

		</style>
	</cfoutput>
</cfif>
<cfoutput>

	<h2 class="u-no-margin-top">
		Targeting State
	</h2>

	<table m-23jyxr class="grid">
	<thead>
		<tr>
			<th>
				Company
			</th>
			<cfloop array="#environments#" index="environment">
				<th>
					#encodeForHtml( environment.name )#
				</th>
			</cfloop>
		</tr>
	</thead>
	<tbody>
		<cfloop array="#companies#" index="company">
			<tr>
				<th scope="row">
					#encodeForHtml( company.subdomain )#
				</th>
				<cfloop array="#environments#" index="environment">
					<td>

						<div m-23jyxr class="states">
							<cfloop array="#company.users#" index="user">
								<cfset result = results[ environment.key ][ user.id ] />

								<span
									data-association="#encodeForHtmlAttribute( environment.key )#:#result.matchingRuleIndex#:#result.variantIndex#"
									class="ui-variant-#result.variantIndex#">
								</span>
							</cfloop>
						</div>

					</td>
				</cfloop>
			</tr>
		</cfloop>
	</tbody>
	</table>

	<ul m-23jyxr class="legend">
		<cfloop array="#utilities.toEntries( feature.variants )#" index="entry">
			<li>
				<span class="ui-variant-#entry.key#">
					#encodeForHtml( serializeJson( entry.value ) )#
				</span>
			</li>
		</cfloop>
	</ul>

	<h3>
		Development Journey
	</h3>

	<ul m-23jyxr class="journey">
		<cfloop array="#utilities.toEntries( journey )#" index="entry">
			<li>
				<a
					href="/index.cfm?event=playground.walkthrough.step#entry.key#"
					#ui.attrClass({
						step: true,
						current: ( attributes.step == entry.key )
					})#>
					Step #encodeForHtml( entry.key )#: #encodeForHtml( entry.value )#
				</a>
			</li>
		</cfloop>
	</ul>

</cfoutput>
