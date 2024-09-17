<cfsavecontent variable="request.template.primaryContent">
	<style type="text/css">

		hr {
			margin: 40px 0 ;
		}

		.grid {
			border-collapse: collapse ;
			border-spacing: 0 ;
			width: 100% ;
		}
		.grid th,
		.grid td {
			border-bottom: 1px solid #cccccc ;
			padding: 7px 10px ;
		}
		.grid thead th {
			border-bottom-width: 2px ;
		}
		.grid tbody tr:hover th,
		.grid tbody tr:hover td {
			background-color: #f0f0f0 ;
		}
		.grid .env-left {
			border-left: 1px solid #cccccc ;
		}
		.grid .env-right {
			border-right: 1px solid #cccccc ;
		}
		.grid .disabled {
			color: #cccccc ;
		}

		.dots {
			display: flex ;
			gap: 5px ;
			justify-content: center ;
		}
		.dots__dot {
			border-radius: 10px ;
			height: 10px ;
			width: 10px ;
		}

		.breakdown {
			display: flex ;
			gap: 2px ;
		}
		.breakdown__item {
			border-radius: 2px ;
			height: 24px ;
			min-width: 2px ;
		}

		.emoji {
			font-family: arial, verdana, sans-serif ;
		}

	</style>
	<cfoutput>

		<section class="content-wrapper u-collapse-margin">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p class="ui-readable-width">
				This application is here to help you learn about
				<span class="emoji">&##x2764;&##xfe0f;</span>
				<a href="https://featureflagsbook.com/" target="_blank">Feature Flags</a>
				<span class="emoji">&##x2764;&##xfe0f;</span>
				Click around and edit the feature flag settings to see how your changes to targeting affect variant allocation against the <a href="/index.cfm?event=playground.users">demo users</a>.
			</p>

			<p class="ui-readable-width">
				You can <a href="/index.cfm?event=playground.features.create">add a feature flag</a>.
				And, at any time, you can
				<a href="/index.cfm?event=playground.features.clear">remove all rules</a> or
				<a href="/index.cfm?event=playground.features.reset">reset your settings</a> (currently on version: #encodeForHtml( version )#).
			</p>

			<table class="grid">
			<thead>
				<tr>
					<th rowspan="2" valign="bottom" align="left">
						Feature
					</th>
					<th rowspan="2" valign="bottom">
						Type
					</th>
					<th rowspan="2" valign="bottom">
						Variants
					</th>
					<cfloop array="#environments#" index="environment">
						<th colspan="2">
							<a href="/index.cfm?event=playground.staging.matrix&environmentKey=#encodeForUrl( environment.key )#">#encodeForHtml( environment.name.ucase() )#</a>
						</th>
					</cfloop>
				</tr>
				<tr>
					<cfloop array="#environments#" index="environment">
						<th class="env-left">
							Rules
						</th>
						<th class="env-right">
							Breakdown
						</th>
					</cfloop>
				</tr>
			</thead>
			<tbody>
				<cfloop array="#features#" index="feature">
					<tr>
						<th align="left" scope="row">
							<a href="/index.cfm?event=playground.features.detail.targeting&featureKey=#encodeForUrl( feature.key )#">#encodeForHtml( feature.key )#</a>
						</th>
						<td align="center">
							#encodeForHtml( feature.type )#
						</td>
						<td align="center">

							<div class="dots">
								<cfloop index="i" from="1" to="#feature.variants.len()#">
									<span class="dots__dot variant-#i#"></span>
								</cfloop>
							</div>

						</td>
						<cfloop array="#environments#" index="environment">
							<td align="center" class="env-left">
								<cfif feature.targeting[ environment.key ].rulesEnabled>
									Enabled
									<cfif feature.targeting[ environment.key ].rules.len()>
										(#feature.targeting[ environment.key ].rules.len()#)
									</cfif>
								<cfelse>
									<span class="disabled">Disabled</span>
								</cfif>
							</td>
							<td class="env-right">

								<cfset breakdown = results[ feature.key ][ environment.key ] />

								<a
									href="/index.cfm?event=playground.features.detail.targeting&featureKey=#encodeForUrl( feature.key )#"
									class="breakdown">
									<cfloop collection="#breakdown#" item="i">
										<cfif breakdown[ i ]>
											<!---
												The flex-grow will cause the breakdown item to
												grow proportionally to the number of users
												that will/would receive this variant.
											--->
											<span
												class="breakdown__item variant-#i#"
												style="flex-grow: #breakdown[ i ]# ;">
											</span>
										</cfif>
									</cfloop>
								</a>
							</td>
						</cfloop>
					</tr>
				</cfloop>
			</tbody>
			</table>

			<hr />

			<p  class="ui-readable-width">
				<strong>GitHub:</strong> The code for this site is available in my <a href="https://github.com/bennadel/FeatureFlagsBookApp" target="_blank">application repository</a> on GitHub. Feel free to fork, download, modify, and run it, etc.
			</p>

		</section>

	</cfoutput>
</cfsavecontent>
