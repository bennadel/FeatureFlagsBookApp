<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<div class="ui-readable-width">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p>
				As you can see on the right, the feature has been enabled for the "dayknight" subdomain. Now, in addition to using the new feature internally on your development team, you have real customers consuming it. This will almost certainly surface new bugs and usability issues.
			</p>

			<p>
				But, no worries &mdash; the vast majority of production users are still receiving the first variant (<span class="ui-variant-1">false</span>) and are still consuming the old version of the feature. This gives you a safe and effective way in which to iterate on the feature right in the production environment.
			</p>

			<h2>
				Next Step
			</h2>

			<p>
				Once the beta-testing period has concluded, we can start releasing this new feature to the general audience. But, we still want to be cautious. Instead of enabling the new feature for <em>everyone</em>, we're going to release it to 25% of the user-base.
			</p>

			<p>
				To do this, we'll change the default resolution of the production environment to be a "distribution" &mdash; instead of a "selection" &mdash; that allocates the <span class="ui-variant-2">true</span> variant to 25% of users:
			</p>

			<cfmodule template="./snippet-1.cfm">

			<form method="get" action="/index.cfm">
				<input type="hidden" name="event" value="playground.walkthrough.step7" />

				<button type="submit" class="ui-button is-submit">
					Enable for 25% of All Users &rarr;
				</button>
			</form>

			<div m-9vuzo9 class="uh-oh u-no-inner-margin-y">

				<h2>
					Side Quest: A Critical Bug Is Discovered!
				</h2>

				<p>
					As a thought experiment, let's imagine that your beta-testing customer uncovered a critical bug in your new feature's implementation. Perhaps the text values are being truncated and the data is being corrupted! We need to prevent more errors from taking place ASAP!
				</p>

				<p>
					This is where feature flags are worth their weight in gold!
				</p>

				<p>
					<a href="/index.cfm?event=playground.walkthrough.step6b">Let's see what we can do</a> &rarr;
				</p>

			</div>

		</div>

		<cfmodule template="../shared/raw.cfm">

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../shared/targeting.cfm" step="6" highlightAssociation="production:3:2">

	</cfoutput>
</cfsavecontent>
