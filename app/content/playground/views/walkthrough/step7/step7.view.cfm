<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p class="ui-readable-width">
			So far things seem to be going really well. No one is reporting bugs - we've even received some compliments on the new feature.
		</p>

		<form method="get">
			<input type="hidden" name="event" value="playground.walkthrough.step8" />

			<button type="submit">
				Enable for 50% of All Users
			</button>
		</form>

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../shared/targeting.cfm" step="7" highlightAssociation="production:0:2">

	</cfoutput>
</cfsavecontent>
