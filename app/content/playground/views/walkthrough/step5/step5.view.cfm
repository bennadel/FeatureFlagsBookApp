<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p class="ui-readable-width">
			At this point you are doing a lot of internal testing and hopefully dog-fooding the feature (ie, using it in your day-to-day workflows). Once you feel confident, perhaps you want to turn it on for a customer's team.
		</p>

		<form method="get">
			<input type="hidden" name="event" value="playground.walkthrough.step6" />

			<button type="submit">
				Enable for Customer Team
			</button>
		</form>

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../shared/targeting.cfm" step="5" highlightAssociation="production:2:2">

	</cfoutput>
</cfsavecontent>
