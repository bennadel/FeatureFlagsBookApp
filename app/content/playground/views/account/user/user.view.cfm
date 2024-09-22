<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="content-wrapper">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p>
				You are logged-in as <strong>#encodeForHtml( user.email )#</strong>.
			</p>

			<p>
				<a href="/index.cfm?event=auth.logout">Logout</a> &rarr;
			</p>

		</section>

	</cfoutput>
</cfsavecontent>
