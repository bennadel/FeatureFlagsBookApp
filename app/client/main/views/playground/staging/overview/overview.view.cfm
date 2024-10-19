<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="ui-content-wrapper">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p class="ui-readable-width">
				The staging area provides a high-level overview of how the feature flag variants are being allocated across all users and environments.
			</p>

			<h2>
				Features
			</h2>

			<ul>
				<cfloop array="#features#" index="feature">
					<li>
						<a href="/index.cfm?event=playground.staging.matrix###encodeForUrl( feature.key )#">#encodeForHtml( feature.key )#</a>
					</li>
				</cfloop>
			</ul>

			<h2>
				Users by Company Subdomain
			</h2>

			<p class="ui-readable-width">
				I've grouped the users by company subdomain because this is a very common way to identify users within targeting rules. Team ID, subdomain, email domain &mdash; after individual users, this level of granularity provides a great way to incrementally enable features.
			</p>

			<cfloop array="#companies#" index="company">

				<h3>
					Company: #encodeForHtml( company.subdomain )#
				</h3>

				<ul>
					<cfloop array="#company.users#" index="user">
						<li>
							<a href="/index.cfm?event=playground.staging.user&userID=#encodeForUrl( user.id )#">#encodeForHtml( user.email )#</a>
						</li>
					</cfloop>
				</ul>

			</cfloop>

		</section>

	</cfoutput>
</cfsavecontent>
