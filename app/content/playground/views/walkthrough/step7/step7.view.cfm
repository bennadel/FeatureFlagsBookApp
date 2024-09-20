<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p class="ui-readable-width">
			As you can see on the right, the new feature is enabled for roughly 25% of all users in the production environment. This may surface new bugs. Or, things might continue on smoothly. And, if they do, we can continue "releasing" the new feature to a wider audience. Let's update the distribution allocation to 50%:
		</p>

		<cfmodule template="./snippet-1.cfm">

		<form method="get">
			<input type="hidden" name="event" value="playground.walkthrough.step8" />

			<button type="submit">
				Enable for 50% of All Users &rarr;
			</button>
		</form>

		<cfmodule template="../shared/raw.cfm">

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../shared/targeting.cfm" step="7" highlightAssociation="production:0:2">

	</cfoutput>
</cfsavecontent>
