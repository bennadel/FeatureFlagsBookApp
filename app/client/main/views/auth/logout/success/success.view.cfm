<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p>
			You've been successfully logged-out of the Feature Flags playground.
		</p>

		<p>
			<a href="/">Back to Home</a>
		</p>

	</cfoutput>
</cfsavecontent>
