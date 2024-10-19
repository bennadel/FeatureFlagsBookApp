<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="ui-content-wrapper">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p>
				You are logged-in as <strong>#encodeForHtml( user.email )#</strong>.
			</p>

			<p>
				<a href="/index.cfm?event=auth.logout">Logout</a> &rarr;
			</p>

			<p>
				<a href="/index.cfm?event=playground.account.delete">Delete account (demo data)</a> &rarr;
			</p>

		</section>

	</cfoutput>
</cfsavecontent>
