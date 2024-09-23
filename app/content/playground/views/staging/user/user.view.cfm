<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="content-wrapper">

			<div class="ui-readable-width">

				<h1>
					#encodeForHtml( title )#
				</h1>

				<p>
					The following properties are used to define the "context" object during feature flag evaluation. Each one of these properties can be used within a rule to target a specific user or subset of users.
				</p>

				<dl>
					<cfloop array="#utilities.toEntries( context )#" index="entry">
						<div>
							<dt>
								"#encodeForHtml( entry.key )#"
							</dt>
							<dd>
								#encodeForHtml( entry.value )#
							</dd>
						</div>
					</cfloop>
				</dl>

				<h2>
					Feature Flag Evaluations
				</h2>

				<p>
					Using your current feature flag configuration, the following variants are being assigned to this user (using the context object above). Click on one of the following variants to see an explanation of the assignment. Or, click on the feature flag key to view and modify the targeting rules.
				</p>

			</div>

			<table class="m12-grid">
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
							Variant
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

							<cfset result = breakdown[ feature.key ][ environment.key ] />

							<td
								align="center"
								class="env-left"
								<cfif result.matchingRuleIndex>style="font-weight: bold ;"</cfif>
								>
								<cfif feature.targeting[ environment.key ].rulesEnabled>
									Enabled
									<cfif feature.targeting[ environment.key ].rules.len()>
										(#feature.targeting[ environment.key ].rules.len()#)
									</cfif>
								<cfelse>
									<span class="disabled">Disabled</span>
								</cfif>
							</td>
							<td class="env-right variant u-variant-#result.variantIndex#">
								<a href="/index.cfm?event=playground.staging.explain&userID=#encodeForUrl( user.id )#&featureKey=#encodeForUrl( feature.key )#&environmentKey=#encodeForUrl( environment.key )#&from=user">#encodeForHtml( serializeJson( result.variant ) )#</a>
							</td>
						</cfloop>
					</tr>
				</cfloop>
			</tbody>
			</table>

		</section>

	</cfoutput>
</cfsavecontent>
