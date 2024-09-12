<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="content-wrapper u-collapse-margin">

			<h1>
				#encodeForHtml( partial.title )#
			</h1>

			<dl class="key-values">
				<div>
					<dt><strong>ID:</strong></dt>
					<dd>#encodeForHtml( partial.user.id )#</dd>
				</div>
				<div>
					<dt><strong>Email:</strong></dt>
					<dd>#encodeForHtml( partial.user.email )#</dd>
				</div>
				<div>
					<dt><strong>Role:</strong></dt>
					<dd>#encodeForHtml( partial.user.role )#</dd>
				</div>
				<div>
					<dt><strong>Company ID:</strong></dt>
					<dd>#encodeForHtml( partial.user.company.id )#</dd>
				</div>
				<div>
					<dt><strong>Company Subdomain:</strong></dt>
					<dd>#encodeForHtml( partial.user.company.subdomain )#</dd>
				</div>
				<div>
					<dt><strong>Company Fortune 100:</strong></dt>
					<dd>#yesNoFormat( partial.user.company.fortune100 )#</dd>
				</div>
				<div>
					<dt><strong>Company Fortune 500:</strong></dt>
					<dd>#yesNoFormat( partial.user.company.fortune500 )#</dd>
				</div>
				<div>
					<dt><strong>Beta Tester:</strong></dt>
					<dd>#yesNoFormat( partial.user.groups.betaTester )#</dd>
				</div>
				<div>
					<dt><strong>Influencer:</strong></dt>
					<dd>#yesNoFormat( partial.user.groups.influencer )#</dd>
				</div>
			</dl>

			<table border="1" cellspacing="2" cellpadding="10">
			<thead>
				<tr>
					<th>
						Feature
					</th>
					<cfloop array="#partial.environments#" index="environment">
						<th>
							<a href="/index.cfm?event=playground.staging.matrix&environmentKey=#encodeForUrl( environment.key )#">#encodeForHtml( environment.name )#</a>
						</th>
					</cfloop>
				</tr>
			</thead>
			<tbody>
				<cfloop array="#partial.features#" index="feature">
					<tr>
						<th scope="row" align="left">
							<a href="/index.cfm?event=playground.features.targeting&featureKey=#encodeForUrl( feature.key )#">#encodeForHtml( feature.key )#</a>
						</th>
						<cfloop array="#partial.environments#" index="environment">
							<td class="variant variant-#partial.breakdown[ feature.key ][ environment.key ].variantIndex#">
								<a href="/index.cfm?event=playground.staging.explain&userID=#encodeForUrl( partial.user.id )#&featureKey=#encodeForUrl( feature.key )#&environmentKey=#encodeForUrl( environment.key )#&from=user">#encodeForHtml( serializeJson( partial.breakdown[ feature.key ][ environment.key ].variant ) )#</a>
							</td>
						</cfloop>
					</tr>
				</cfloop>
			</tbody>
			</table>

		</section>

	</cfoutput>
</cfsavecontent>
