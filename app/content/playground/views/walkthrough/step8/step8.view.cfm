<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p class="ui-readable-width">
			Wow, things are going so smoothly!
		</p>

		<form method="get">
			<input type="hidden" name="event" value="playground.walkthrough.step9" />

			<button type="submit">
				Enable for All Users
			</button>
		</form>

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../shared/targeting.cfm" step="8" highlightAssociation="production:0:2">

	</cfoutput>
</cfsavecontent>
