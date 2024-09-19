<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p class="ui-readable-width">
			Awesome, your customer has been helping you test it out. They've found some bugs and suggested some improvements. Once things feel solid, we can start progressively releasing it to a wider audience.
		</p>

		<form method="get">
			<input type="hidden" name="event" value="playground.walkthrough.step7" />

			<button type="submit">
				Enable for 25% of All Users
			</button>
		</form>

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../shared/targeting.cfm" step="6" highlightAssociation="production:3:2">

	</cfoutput>
</cfsavecontent>
