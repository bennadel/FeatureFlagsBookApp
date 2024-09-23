<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="content-wrapper">

			<div class="ui-readable-width">

				<h1>
					#encodeForHtml( title )#
				</h1>

				<p>
					This application is here to help you learn about
					<span class="ui-emoji">&##x2764;&##xfe0f;</span>
					<a href="https://featureflagsbook.com/" target="_blank">Feature Flags</a>
					<span class="ui-emoji">&##x2764;&##xfe0f;</span>
					Click around and edit the feature flag settings to see how changes to the targeting affect variant allocation against the <a href="/index.cfm?event=playground.users">demo users</a>.
				</p>

				<h2>
					Start With a Feature Development Walk-Through
				</h2>

				<p>
					Feature flags will completely change the way you think about product development. But, integrating feature flags into your feature development life-cycle is a learning process. If you're new to feature flags, let's walk-through a small feature journey together.
				</p>

				<p>
					<a href="/index.cfm?event=playground.walkthrough"><mark>Start feature development walk-through</mark></a> &rarr;
				</p>

			</div>

			<hr class="ui-rule" />

			<div class="ui-readable-width">

				<h2>
					Your Feature Flag Dashboard
				</h2>

				<p>
					You can:
					<a href="/index.cfm?event=playground.features.create"><strong>add</strong> a feature flag</a>,
					<a href="/index.cfm?event=playground.features.clear"><strong>remove</strong> all rules</a> or,
					<a href="/index.cfm?event=playground.features.reset"><strong>reset</strong> your settings</a>.
					<!--- (currently on version: #encodeForHtml( version )#). --->
				</p>

			</div>

			<table class="m5-grid">
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

							<div class="ui-dots">
								<cfloop from="1" to="#feature.variants.len()#" index="i">
									<span class="ui-dots__dot u-variant-#i#"></span>
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
									class="ui-breakdown-bar">
									<cfloop collection="#breakdown#" item="i">
										<cfif breakdown[ i ]>
											<!---
												The flex-grow will cause the breakdown item to
												grow proportionally to the number of users
												that will/would receive this variant.
											--->
											<span
												class="ui-breakdown-bar__item u-variant-#i#"
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

			<p class="ui-readable-width">
				<strong>GitHub:</strong> The code for this site is available in my <a href="https://github.com/bennadel/FeatureFlagsBookApp" target="_blank">application repository</a> on GitHub. Feel free to fork, download, modify, and run it, etc.
			</p>

		</section>

	</cfoutput>
</cfsavecontent>
