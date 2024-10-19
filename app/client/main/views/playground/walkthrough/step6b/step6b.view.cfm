<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<div class="ui-readable-width">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p>
				With the recent feature flag configuration changes instantly reverted, your development team is now the only team receiving the <span class="ui-variant-2">true</span> variant in production. This simple action prevented new bugs from occurring and halted the corruption of data. This also affords your development team time to debug and correct the feature behavior.
			</p>

			<p>
				You didn't have to modify the code.
			</p>

			<p>
				You didn't have to deploy anything.
			</p>

			<p>
				You're freaking amazing!
			</p>

			<p>
				Your boss owes you a raise!
			</p>

			<h2>
				Next Step
			</h2>

			<p>
				Once the beta-testing period has concluded and all nascent bugs have been addressed, we can start releasing this new feature to the general audience. But, we still want to be cautious. Instead of enabling the new feature for <em>everyone</em>, we're going to release it to 25% of the user-base.
			</p>

			<p>
				To do this, we'll change the default resolution of the production environment to be a "distribution" &mdash; instead of a "selection" &mdash; that allocates the <span class="ui-variant-2">true</span> variant to <mark>25% of users</mark>:
			</p>

			<cfmodule template="./snippet-1.cfm">

			<form method="get" action="/index.cfm">
				<input type="hidden" name="event" value="playground.walkthrough.step7" />

				<button type="submit" class="ui-button is-submit">
					Enable Feature for 25% of All Users &rarr;
				</button>
			</form>

		</div>

		<cfmodule template="../common/raw.cfm">

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../common/targeting.cfm" step="6" highlightAssociation="production:2:2">

	</cfoutput>
</cfsavecontent>
