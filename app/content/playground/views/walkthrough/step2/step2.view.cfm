<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p class="ui-readable-width">
			Ok, we now have a new feature in a default state. Every user is receiving the same value. To start development, let's enable the feature locally.
		</p>

		<form method="get">
			<input type="hidden" name="event" value="playground.walkthrough.step3" />

			<button type="submit">
				Enable in Development
			</button>
		</form>

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../shared/targeting.cfm" step="2">

	</cfoutput>
</cfsavecontent>
