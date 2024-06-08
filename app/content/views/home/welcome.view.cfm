<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			Feature flag stuff will happen soon.
			<a href="/index.cfm?event=staging">See evaluations</a>.
		</p>

		<cfdump var="#request.user#" />

		<p>
			<a href="/index.cfm?event=auth.logout">Logout</a>
		</p>

	</cfoutput>
</cfsavecontent>
