<cfsavecontent variable="request.template.primaryContent">
	<style type="text/css">

		.state {
			border-collapse: collapse ;
			border-spacing: 0 ;
		}

		.state thead th {
			background-color: #ffffff ;
			padding: 14px 25px ;
			position: sticky ;
			top: 0 ;
			white-space: nowrap ;
			z-index: 3 ;
		}

		.state tbody th {
			background-color: #ffffff ;
			left: 0 ;
			padding: 15px 20px ;
			position: sticky ;
			white-space: nowrap ;
			z-index: 2 ;
		}

		.state thead th:after,
		.state tbody th:after {
			border: 2px solid #cccccc ;
			content: "" ;
			inset: 0 ;
			pointer-events: none ;
			position: absolute ;
		}
		.state thead th:after {
			border-width: 2px 1px 2px 1px ;
		}
		.state tbody th:after {
			border-width: 0px 2px 2px 2px ;
		}

		.state td {
			border: 1px solid #ffffff ;
			border-width: 0px 1px 1px 0px ;
			padding: 8px 20px ;
			white-space: nowrap ;
		}
		/* Colors from : https://colorbrewer2.org/#type=qualitative&scheme=Set2&n=6 */
		.state td.variant-0 { background-color: #66c2a5 ; }
		.state td.variant-1 { background-color: #ffd92f ; }
		.state td.variant-2 { background-color: #a6d854 ; }
		.state td.variant-3 { background-color: #e78ac3 ; }
		.state td.variant-4 { background-color: #8da0cb ; }
		.state td.variant-5 { background-color: #fc8d62 ; }
		.state td.variant-6 { background-color: #66c2a5 ; }

		.user-name {
			border: 1px dashed #cccccc ;
			margin: 0 0 15px 0 ;
			padding: 10px ;
			text-align: center ;
		}

		.user-context {
			font-size: 16px ;
			margin: 0 ;
			padding: 0 ;
			text-align: left ;
		}
		.user-context div {
			display: flex ;
			margin-block: 5px ;
		}
		.user-context div:first-child {
			margin-top: 0 ;
		}
		.user-context div:last-child {
			margin-bottom: 0 ;
		}
		.user-context dt {
			color: #999999 ;
			margin: 0 10px 0 0 ;
			padding: 0 ;
		}
		.user-context dd {
			margin: 0 ;
			padding: 0 ;
		}

	</style>
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			<strong>Environments:</strong>

			<cfloop array="#demoEnvironments#" index="demoEnvironment">

				<cfif ( demoEnvironment.key == environmentName )>

					<a href="/index.cfm?event=home.evaluate&environmentName=#encodeForHtml( demoEnvironment.key )#"><strong>#encodeForHtml( demoEnvironment.name )#</strong></a>

				<cfelse>

					<a href="/index.cfm?event=home.evaluate&environmentName=#encodeForHtml( demoEnvironment.key )#">#encodeForHtml( demoEnvironment.name )#</a>

				</cfif>

			</cfloop>
		</p>

		<p>
			<strong>Description:</strong>
			#encodeForHtml( config.environments[ environmentName ].description )#
		</p>

		<table class="state">
		<thead>
			<th scope="col">
				User
			</th>
			<cfloop array="#demoFeatureFlags#" item="demoFeatureFlag">

				<th scope="col">
					#encodeForHtml( demoFeatureFlag.key )#
				</th>

			</cfloop>
		</thead>
		<tbody>
			<cfloop array="#demoUsers#" index="demoUser">
				<tr>
					<th scope="row">

						<p class="user-name">
							#encodeForHtml( demoUser.name )#
						</p>

						<dl class="user-context">
							<div>
								<dt>key:</dt>
								<dd>#encodeForHtml( demoUser.id )#</dd>
							</div>
							<div>
								<dt>user.id:</dt>
								<dd>#encodeForHtml( demoUser.id )#</dd>
							</div>
							<div>
								<dt>user.email:</dt>
								<dd>#encodeForHtml( demoUser.email )#</dd>
							</div>
							<div>
								<dt>user.role:</dt>
								<dd>#encodeForHtml( demoUser.role )#</dd>
							</div>
							<div>
								<dt>user.company.id:</dt>
								<dd>#encodeForHtml( demoUser.company.id )#</dd>
							</div>
							<div>
								<dt>user.company.subdomain:</dt>
								<dd>#encodeForHtml( demoUser.company.subdomain )#</dd>
							</div>
							<div>
								<dt>user.company.fortune100:</dt>
								<dd>#encodeForHtml( demoUser.company.fortune100 )#</dd>
							</div>
							<div>
								<dt>user.company.fortune500:</dt>
								<dd>#encodeForHtml( demoUser.company.fortune500 )#</dd>
							</div>
							<div>
								<dt>user.groups.betaTester:</dt>
								<dd>#encodeForHtml( demoUser.groups.betaTester )#</dd>
							</div>
							<div>
								<dt>user.groups.influencer:</dt>
								<dd>#encodeForHtml( demoUser.groups.influencer )#</dd>
							</div>
						</dl>
					</th>
					<cfloop array="#demoFeatureFlags#" item="demoFeatureFlag">

						<!---
							A feature flag has to be evaluated against a context. The
							only required property is "key", which is used to
							differentiate unique "clients" and to provide predictable
							percent-based allocations. This property, as well as any
							other custom property, can be used within the rule
							evaluation.
							--
							Note: The dot-delimited key isn't a requirement - it's
							just a convention that I am using to convert complex
							objects into predictable simple values.
						--->
						<cfset userContext = [
							"key": demoUser.id,
							"user.id": demoUser.id,
							"user.email": demoUser.email,
							"user.role": demoUser.role,
							"user.company.id": demoUser.company.id,
							"user.company.subdomain": demoUser.company.subdomain,
							"user.company.fortune100": demoUser.company.fortune100,
							"user.company.fortune500": demoUser.company.fortune500,
							"user.groups.betaTester": demoUser.groups.betaTester,
							"user.groups.influencer": demoUser.groups.influencer
						] />

						<cfset variant = featureFlags.getVariant(
							feature = demoFeatureFlag.key,
							environment = environmentName,
							context = userContext,
							fallbackVariant = "FALLBACK"
						) />
						<!---
							The index of the variant provides a way to color-code
							different values so that they are easier to discern in the
							evaluation grid.
						--->
						<cfset variantIndex = arrayFind( demoFeatureFlag.variants, variant ) />

						<td align="center" valign="center" class="variant-#variantIndex#">
							#encodeForHtml( serializeJson( variant ) )#
						</td>

					</cfloop>
				</tr>
			</cfloop>

		</tbody>
		</table>

	</cfoutput>
</cfsavecontent>
