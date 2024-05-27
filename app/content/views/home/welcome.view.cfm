<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			Feature flag stuff will happen soon.
		</p>

		<cfdump var="#request.user#" />

		<p>
			<a href="/index.cfm?event=auth.logout">Logout</a>
		</p>

	</cfoutput>
</cfsavecontent>
