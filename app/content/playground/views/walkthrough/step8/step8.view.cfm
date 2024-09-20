<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p class="ui-readable-width">
			As you can see on the right, the new feature is now enabled for roughly 50% of all users in the production environment. How exciting is this?! How much safer do you feel releasing a new feature gradually instead of all at once?
		</p>

		<p class="ui-readable-width">
			It's time to release the new feature to the entire user-base. To do this, we'll update the production resolution to distribute the <span class="variant-2">true</span> variant to 100% of users:
		</p>

		<cfmodule template="./snippet-1.cfm">

		<form method="get">
			<input type="hidden" name="event" value="playground.walkthrough.step9" />

			<button type="submit">
				Enable for All Users &rarr;
			</button>
		</form>

		<cfmodule template="../shared/raw.cfm">

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../shared/targeting.cfm" step="8" highlightAssociation="production:0:2">

	</cfoutput>
</cfsavecontent>
