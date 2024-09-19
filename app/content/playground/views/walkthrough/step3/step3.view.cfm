<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p class="ui-readable-width">
			You've worked hard on your feature in the development environment. Now, it's time to start progressively releasing it in production. Let's start with just your user.
		</p>

		<form method="get">
			<input type="hidden" name="event" value="playground.walkthrough.step4" />

			<button type="submit">
				Enable for Yourself
			</button>
		</form>

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../shared/targeting.cfm" step="3" highlightAssociation="development:0:2">

	</cfoutput>
</cfsavecontent>
