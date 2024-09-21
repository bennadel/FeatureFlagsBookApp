<style type="text/css">

	.grid thead th {
		padding: 0 5px 5px 5px ;
		text-align: left ;
	}
	.grid thead th:first-child {
		padding-left: 0 ;
	}
	.grid tbody th {
		padding: 5px 20px 5px 0 ;
		text-align: left ;
	}
	.grid td {
		padding: 5px 20px 5px 0 ;
	}
	.grid td:last-child {
		padding-right: 0 ;
	}

	.states {
		display: flex ;
		gap: 3px ;
	}
	.states span {
		border-radius: 3px ;
		flex: 0 0 auto ;
		height: 1vw ;
		height: clamp( 13px, 1vw, 23px ) ;
		width: 1vw ;
		width: clamp( 13px, 1vw, 23px ) ;
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
				opacity: 0.3 ;
			}
			.states span[ data-association = "#attributes.highlightAssociation#" ] {
				animation: pulsate 2.2s infinite ease-in-out ;
				opacity: 1.0 ;
			}

			@keyframes pulsate {
				50% {
					border-radius: 10px ;
					transform: scale( 0.3 ) ;
				}
			}
		</style>
	</cfoutput>
</cfif>
<cfoutput>

	<h2 style="margin-top: 0 ;">
		Targeting State
	</h2>

	<table class="grid">
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

	<ul class="table-legend">
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

	<ul class="journey">
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
