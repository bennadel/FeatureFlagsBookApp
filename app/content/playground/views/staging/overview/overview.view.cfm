<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="content-wrapper u-collapse-margin">

			<h1>
				#encodeForHtml( partial.title )#
			</h1>

			<h2>
				Environments
			</h2>

			<ul>
				<cfloop array="#partial.environments#" index="environment">
					<li>
						<a href="/index.cfm?event=playground.staging.matrix&environmentKey=#encodeForUrl( environment.key )#">#encodeForHtml( environment.name )#</a>
					</li>
				</cfloop>
			</ul>

			<h2>
				Users
			</h2>

			<ul>
				<cfloop array="#partial.users#" index="user">
					<li>
						<a href="/index.cfm?event=playground.staging.user&userID=#encodeForUrl( user.id )#">#encodeForHtml( user.email )#</a>
					</li>
				</cfloop>
			</ul>

		</section>

	</cfoutput>
</cfsavecontent>
