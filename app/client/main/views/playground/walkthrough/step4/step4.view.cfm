<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<div class="ui-readable-width">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p>
				As you can see on the right, by targeting your user specifically (via email address), we're able to "release" the new feature to your user in production without releasing it to any other users. Now, you can test the feature in the actual production environment, with actual production data and actual production dependencies, without disrupting anyone else's experience.
			</p>

			<h2>
				Next Step
			</h2>

			<p>
				Once you're satisfied that the feature is working well enough (for your user), we can release the feature to your entire development team. This will allow your team to <a href="https://en.wikipedia.org/wiki/Eating_your_own_dog_food" target="_blank">"dog food" the feature</a>. To do this, we'll add a rule that targets your team's subdomain, "<mark>devteam</mark>", and serves up the second variant (<span class="ui-variant-2">true</span>):
			</p>

			<cfmodule template="./snippet-1.cfm">

			<p>
				When the feature flags client evaluates a feature flag for a given user in a given environment, it iterates over these rules in a top-down manner. Whichever rule matches first, wins (and provides the variant identified by the associated resolution).
			</p>

			<form method="get" action="/index.cfm">
				<input type="hidden" name="event" value="playground.walkthrough.step5" />

				<button type="submit" class="ui-button is-submit">
					Enable Feature for Your Development Team &rarr;
				</button>
			</form>

		</div>

		<cfmodule template="../common/raw.cfm">

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../common/targeting.cfm" step="4" highlightAssociation="production:1:2">

	</cfoutput>
</cfsavecontent>
