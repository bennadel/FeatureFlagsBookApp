<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p class="ui-readable-width">
			As you can see on the right, by targeting your user specifically (via email address), we were able to "release" the new feature to your user in production without releasing it to any other users. Now, you can test the feature in the actual production environment, with actual production data and actual production dependencies, without disrupting anyone else's experience.
		</p>

		<p class="ui-readable-width">
			And, once you're satisfied that the feature is working well enough, we can release the feature to your entire development team. This will allow the team to "dog food" the feature. To do this, we'll add a rule that targets your team's subdomain, "devteam":
		</p>

		<cfmodule template="./snippet-1.cfm">

		<form method="get">
			<input type="hidden" name="event" value="playground.walkthrough.step5" />

			<button type="submit">
				Enable for Your Development Team &rarr;
			</button>
		</form>

		<cfmodule template="../shared/raw.cfm">

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../shared/targeting.cfm" step="4" highlightAssociation="production:1:2">

	</cfoutput>
</cfsavecontent>
