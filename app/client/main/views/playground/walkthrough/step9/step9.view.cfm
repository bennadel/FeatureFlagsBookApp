<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<div class="ui-readable-width">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p>
				As you can see on the right, the new feature is now enabled for all users in the production environment. Congratulations, you just progressively developed and deployed a new feature with unparalleled safety and an intoxicating amount of confidence.
			</p>

			<h2>
				Next Step
			</h2>

			<p>
				At this point, we should let the feature "soak" in production for some period of time, leaving the new feature code gated behind the feature flag in case an emergency revert needs to take place (albeit highly unlikely).
			</p>

			<p>
				We could leave the distribution allocation at 100% while the feature soaks. But, for the sake of the walk-through, let's delete the rules and update the default resolution in the production environment to serve up the second variant (<span class="ui-variant-2">true</span>):
			</p>

			<cfmodule template="./snippet-1.cfm">

			<p>
				This change in the configuration makes no difference to the users &mdash; 100% of production users are still receiving the <span class="ui-variant-2">true</span> variant. We've simply changed the underlying resolution mechanics from "distribution" to "selection".
			</p>

			<form method="get" action="/index.cfm">
				<input type="hidden" name="event" value="playground.walkthrough.step10" />

				<button type="submit" class="ui-button is-submit">
					Let Fully-Enabled Feature Soak in Production &rarr;
				</button>
			</form>

		</div>

		<cfmodule template="../common/raw.cfm">

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../common/targeting.cfm" step="9" highlightAssociation="production:0:2">

	</cfoutput>
</cfsavecontent>
