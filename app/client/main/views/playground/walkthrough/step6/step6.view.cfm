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
				Oh No! <mark>A Critical Bug Is Discovered!</mark>
			</h2>

			<p>
				Your beta-testing customer has uncovered a critical bug in your new feature's implementation. In certain edge-cases, the text values are being truncated and the data is being corrupted! We need to prevent more errors from taking place ASAP!
			</p>

			<p>
				This is where feature flags are worth their weight in gold!
			</p>

			<p>
				Since feature flags <strong>decouple the concept of "deployment" from the concept of "release"</strong>, we <em>don't</em> have to modify any code and we <em>don't</em> have to deploy anything to production. All we have to do is revert the changes we made to the feature configuration.
			</p>

			<h2>
				Next Step
			</h2>

			<p>
				Let's remove the rule that targets the company subdomain, "<mark>dayknight</mark>", and which serves up the second variant (<span class="ui-variant-2">true</span>):
			</p>

			<cfmodule template="./snippet-1.cfm">

			<p>
				When we make this change, the feature flag evaluations in the production environment will be <em>instantaneously</em> reverted in our beta-tester's subdomain. Users under the subdomain "<mark>dayknight</mark>" will, once again, start receiving the first variant (<span class="ui-variant-1">false</span>). Which means the old plain-text version of the feature will be rendered; and, no more data will be corrupted.
			</p>

			<form method="get" action="/index.cfm">
				<input type="hidden" name="event" value="playground.walkthrough.step6b" />

				<button type="submit" class="ui-button is-submit">
					Roll-Back the Configuration Changes &rarr;
				</button>
			</form>

		</div>

		<cfmodule template="../common/raw.cfm">

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../common/targeting.cfm" step="6" highlightAssociation="production:3:2">

	</cfoutput>
</cfsavecontent>
