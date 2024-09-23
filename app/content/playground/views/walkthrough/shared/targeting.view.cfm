<cfif attributes.highlightAssociation.len()>
	<cfoutput>
		<style type="text/css">

			.m7-states span {
				opacity: 0.3 ;
			}
			.m7-states span[ data-association = "#attributes.highlightAssociation#" ] {
				animation: m7-pulsate 2.2s infinite ease-in-out ;
				opacity: 1.0 ;
			}

		</style>
	</cfoutput>
</cfif>
<cfoutput>

	<h2 class="u-no-margin-top">
		Targeting State
	</h2>

	<table class="m7-grid">
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

						<div class="m7-states">
							<cfloop array="#company.users#" index="user">
								<cfset result = results[ environment.key ][ user.id ] />

								<span
									data-association="#encodeForHtmlAttribute( environment.key )#:#result.matchingRuleIndex#:#result.variantIndex#"
									class="u-variant-#result.variantIndex#">
								</span>
							</cfloop>
						</div>

					</td>
				</cfloop>
			</tr>
		</cfloop>
	</tbody>
	</table>

	<ul class="m7-legend">
		<cfloop array="#utilities.toEntries( feature.variants )#" index="entry">
			<li>
				<span class="u-variant-#entry.key#">
					#encodeForHtml( serializeJson( entry.value ) )#
				</span>
			</li>
		</cfloop>
	</ul>

	<h3>
		Development Journey
	</h3>

	<ul class="m7-journey">
		<cfloop array="#utilities.toEntries( journey )#" index="entry">
			<li>
				<a
					href="/index.cfm?event=playground.walkthrough.step#entry.key#"
					#ui.attrClass({
						step: true,
						current: ( attributes.step == entry.key )
					})#>
					Step #entry.key#: #encodeForHtml( entry.value )#
				</a>
			</li>
		</cfloop>
	</ul>

</cfoutput>
