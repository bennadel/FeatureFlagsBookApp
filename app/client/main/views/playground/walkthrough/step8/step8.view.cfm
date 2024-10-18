<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<div class="ui-readable-width">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p>
				As you can see on the right, the new feature is now enabled for roughly 50% of all users in the production environment. How exciting is this?! How much safer do you feel releasing a new feature gradually instead of all at once?
			</p>

			<h2>
				Next Step
			</h2>

			<p>
				It's time to release the new feature to the entire user-base. To do this, we'll update the production resolution to distribute the <span class="ui-variant-2">true</span> variant to <mark>100% of users</mark>:
			</p>

			<cfmodule template="./snippet-1.cfm">

			<form method="get" action="/index.cfm">
				<input type="hidden" name="event" value="playground.walkthrough.step9" />

				<button type="submit" class="ui-button is-submit">
					Enable for All Users &rarr;
				</button>
			</form>

		</div>

		<cfmodule template="../common/raw.cfm">

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../common/targeting.cfm" step="8" highlightAssociation="production:0:2">

	</cfoutput>
</cfsavecontent>
