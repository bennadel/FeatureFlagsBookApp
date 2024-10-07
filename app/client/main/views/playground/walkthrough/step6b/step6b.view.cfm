<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<div class="ui-readable-width">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p>
				Your customer discovered a critical bug that slipped past your development team. It's an unfortunate situation. But, feature flags can really help us out in this scenario.
			</p>

			<p>
				Since feature flags <strong>decouple the concept of "deployment" from the concept of "release"</strong>, we <em>don't</em> have to modify any code and we <em>don't</em> have to deploy anything to production. All we have to do is revert the changes we made to the feature configuration.
			</p>

			<h2>
				Next Step
			</h2>

			<p>
				Let's remove the rule that targets the company subdomain, "dayknight", and which serves up the second variant (<span class="ui-variant-2">true</span>):
			</p>

			<cfmodule template="./snippet-1.cfm">

			<p>
				When we make this change, the feature flag evaluations in the production environment will be <em>instantaneously</em> reverted in our beta-tester's subdomain. Users under the subdomain "dayknight" will start receiving the first variant (<span class="ui-variant-1">false</span>). Which means the old version of the feature will be rendered; and, no more data will be corrupted.
			</p>

			<form method="get" action="/index.cfm">
				<input type="hidden" name="event" value="playground.walkthrough.step6c" />

				<button type="submit" class="ui-button is-submit">
					Roll-Back the Changes &rarr;
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
