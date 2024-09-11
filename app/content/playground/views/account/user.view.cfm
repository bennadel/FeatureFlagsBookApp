<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="content-wrapper u-collapse-margin">

			<h1>
				#encodeForHtml( request.template.title )#
			</h1>

			<p>
				You are logged-in as <strong>#encodeForHtml( request.user.email )#</strong>.
			</p>

			<p>
				<a href="/index.cfm?event=auth.logout">Logout</a> &rarr;
			</p>

		</section>

	</cfoutput>
</cfsavecontent>
