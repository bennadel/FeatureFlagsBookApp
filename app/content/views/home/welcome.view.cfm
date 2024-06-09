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

		<p>
			<strong>GitHub:</strong> The code for this site is available in my <a href="https://github.com/bennadel/FeatureFlagsBookApp">application repository</a> on GitHub. Feel free to fork, download, modify, and run it, etc. This repository is here to help you learn about Feature Flags.
		</p>

	</cfoutput>
</cfsavecontent>
