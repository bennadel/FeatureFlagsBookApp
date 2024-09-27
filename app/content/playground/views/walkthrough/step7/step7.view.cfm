<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<div class="ui-readable-width">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p>
				As you can see on the right, the new feature is now enabled for roughly 25% of all users in the production environment. This may surface new bugs. Or, things might continue on smoothly.

			</p>

			<h2>
				Next Step
			</h2>

			<p>
				When you feel confidence in the stability of the new feature, we can continue "releasing" the new feature to a wider audience. Let's update the distribution allocation to 50%:
			</p>

			<cfmodule template="./snippet-1.cfm">

			<form method="get" action="/index.cfm">
				<input type="hidden" name="event" value="playground.walkthrough.step8" />

				<button type="submit" class="ui-button is-submit">
					Enable for 50% of All Users &rarr;
				</button>
			</form>

		</div>

		<cfmodule template="../shared/raw.cfm">

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../shared/targeting.cfm" step="7" highlightAssociation="production:0:2">

	</cfoutput>
</cfsavecontent>
