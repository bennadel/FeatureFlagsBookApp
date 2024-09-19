<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p class="ui-readable-width">
			So far so good, the feature seems to work for your user. Now, let's try enabling it for your whole team.
		</p>

		<form method="get">
			<input type="hidden" name="event" value="playground.walkthrough.step5" />

			<button type="submit">
				Enable for Your Team
			</button>
		</form>

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../shared/targeting.cfm" step="4" highlightAssociation="production:1:2">

	</cfoutput>
</cfsavecontent>
