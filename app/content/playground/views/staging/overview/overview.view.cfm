<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="content-wrapper u-collapse-margin">

			<h1>
				#encodeForHtml( title )#
			</h1>

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
				Users
			</h2>

			<ul>
				<cfloop array="#users#" index="user">
					<li>
						<a href="/index.cfm?event=playground.staging.user&userID=#encodeForUrl( user.id )#">#encodeForHtml( user.email )#</a>
					</li>
				</cfloop>
			</ul>

		</section>

	</cfoutput>
</cfsavecontent>
