<style type="text/css">

	.states {
		display: flex ;
		gap: 3px ;
	}
	.states span {
		border-radius: 3px ;
		flex: 0 0 auto ;
		height: 1vw ;
		width: 1vw ;
	}

	.table-legend {
		display: flex ;
		gap: 13px ;
		list-style-type: none ;
		margin: 0 ;
		padding: 0 ;
	}
	.table-legend li {
		margin: 0 ;
		padding: 0 ;
	}
	.table-legend span {
		border-radius: 3px ;
		display: block ;
		padding: 3px 10px ;
	}

	.journey {}
	.journey .step {}
	.journey .current {
		background-color: #f0f0f0 ;
		font-weight: bold ;
	}

</style>
<cfif attributes.highlightAssociation.len()>
	<cfoutput>
		<style type="text/css">

			.states span {
				opacity: 0.4 ;
			}
			.states span[ data-association = "#attributes.highlightAssociation#" ] {
				box-shadow: 0px 0px 4px 2px deeppink ;
				opacity: 1.0 ;
			}

		</style>
	</cfoutput>
</cfif>
<cfoutput>

	<h2 style="margin-top: 0 ;">
		Targeting State
	</h2>

	<table>
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
						<div class="states">
							<cfloop array="#company.users#" index="user">
								<cfset result = results[ environment.key ][ user.id ] />

								<span
									data-association="#encodeForHtmlAttribute( environment.key )#:#result.matchingRuleIndex#:#result.variantIndex#"
									class="variant-#result.variantIndex#">
								</span>
							</cfloop>
						</div>
					</td>
				</cfloop>
			</tr>
		</cfloop>
	</tbody>
	</table>


	<ul class="table-legend">
		<cfloop array="#utilities.toEntries( feature.variants )#" index="entry">
			<li>
				<span class="variant-#entry.key#">
					#encodeForHtml( serializeJson( entry.value ) )#
				</span>
			</li>
		</cfloop>
	</ul>

	<h3>
		Development Journey
	</h3>

	<ul class="journey">
		<li>
			<a
				href="/index.cfm?event=playground.walkthrough.step2"
				#ui.attrClass({
					step: true,
					current: ( attributes.step == 2 )
				})#>
				Step 2: Initial Feature State
			</a>
		</li>
		<li>
			<a
				href="/index.cfm?event=playground.walkthrough.step3"
				#ui.attrClass({
					step: true,
					current: ( attributes.step == 3 )
				})#>
				Step 3: Enable in Development Environment
			</a>
		</li>
		<li>
			<a
				href="/index.cfm?event=playground.walkthrough.step4"
				#ui.attrClass({
					step: true,
					current: ( attributes.step == 4 )
				})#>
				Step 4: Solo Testing in Production
			</a>
		</li>
		<li>
			<a
				href="/index.cfm?event=playground.walkthrough.step5"
				#ui.attrClass({
					step: true,
					current: ( attributes.step == 5 )
				})#>
				Step 5: Internal Testing in Production
			</a>
		</li>
		<li>
			<a
				href="/index.cfm?event=playground.walkthrough.step6"
				#ui.attrClass({
					step: true,
					current: ( attributes.step == 6 )
				})#>
				Step 6: Beta Testing With Customer
			</a>
		</li>
		<li>
			<a
				href="/index.cfm?event=playground.walkthrough.step7"
				#ui.attrClass({
					step: true,
					current: ( attributes.step == 7 )
				})#>
				Step 7: Cautious Roll-Out to 25% of Users
			</a>
		</li>
		<li>
			<a
				href="/index.cfm?event=playground.walkthrough.step8"
				#ui.attrClass({
					step: true,
					current: ( attributes.step == 8 )
				})#>
				Step 8: Cautious Roll-Out to 50% of Users
			</a>
		</li>
		<li>
			<a
				href="/index.cfm?event=playground.walkthrough.step9"
				#ui.attrClass({
					step: true,
					current: ( attributes.step == 9 )
				})#>
				Step 9: Enable Feature For All Users
			</a>
		</li>
		<li>
			<a
				href="/index.cfm?event=playground.walkthrough.step10"
				#ui.attrClass({
					step: true,
					current: ( attributes.step == 10 )
				})#>
				Step 10: Soaking in Production
			</a>
		</li>
		<li>
			<a href="/index.cfm?event=playground.walkthrough.step11" class="step">
				Step 11: Delete Feature Flag
			</a>
		</li>
	</ul>
	</ul>

</cfoutput>
