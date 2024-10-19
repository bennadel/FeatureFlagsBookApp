<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<div class="ui-readable-width">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p>
				As you can see on the right (the throbbing green squares), every user in the development environment is now receiving the <span class="ui-variant-2">true</span> variant. We can now start the development of our new feature in the development environment by wrapping our new code in a conditional check:
			</p>

			<cfmodule template="./snippet-1.cfm">

			<p>
				With this new code tucked safely behind a feature flag, we can deploy this code to production at any time without actually "releasing" the new feature to any users. Since all users in the production environment are still receiving the <span class="ui-variant-1">false</span> variant, all users in the production environment will continue to see the old, plain-text editor.
			</p>

			<h2>
				Next Step
			</h2>

			<p>
				Once the new feature has been developed, we can start to incrementally release it to our production users. Let's start by releasing the feature to <em>your user</em> only. To do this, we'll add a rule that targets your email address (<mark>#encodeForHtml( request.user.email )#</mark>):
			</p>

			<cfmodule template="./snippet-2.cfm">

			<form method="get" action="/index.cfm">
				<input type="hidden" name="event" value="playground.walkthrough.step4" />

				<button type="submit" class="ui-button is-submit">
					Enable Feature for Your User in Production &rarr;
				</button>
			</form>

		</div>

		<cfmodule template="../common/raw.cfm">

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../common/targeting.cfm" step="3" highlightAssociation="development:0:2">

	</cfoutput>
</cfsavecontent>
