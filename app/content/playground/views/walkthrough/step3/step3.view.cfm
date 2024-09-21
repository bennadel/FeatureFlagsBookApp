<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p class="ui-readable-width">
			As you can see on the right, every user in the development environment is now receiving the <span class="u-variant-2">true</span> variant. We can now start the development of our new feature in the development environment by wrapping our new code in a conditional check:
		</p>

		<cfmodule template="./snippet-1.cfm">

		<p class="ui-readable-width">
			With this new code tucked safely behind a feature flag, we can deploy this code to production at any time without actually "releasing" the new feature to any users. Since all users in the production environment are still receiving the <span class="u-variant-1">false</span> variant, all users in the production environment will continue to see the old, plain-text editor.
		</p>

		<p class="ui-readable-width">
			But, once the new feature has been developed, we can start to incrementally release it to our production users. Let's start by releasing the feature to <em>your user</em> only. To do this, we'll add a rule that targets your email address (#encodeForHtml( request.user.email )#):
		</p>

		<cfmodule template="./snippet-2.cfm">

		<form method="get">
			<input type="hidden" name="event" value="playground.walkthrough.step4" />

			<button type="submit">
				Enable for Your User in Production &rarr;
			</button>
		</form>

		<cfmodule template="../shared/raw.cfm">

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../shared/targeting.cfm" step="3" highlightAssociation="development:0:2">

	</cfoutput>
</cfsavecontent>
