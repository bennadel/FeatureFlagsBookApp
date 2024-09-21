<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p class="ui-readable-width">
			Your customer discovered a critical bug that slipped past your development team. It's an unfortunate situation. But, feature flags can really help us out in this scenario.
		</p>

		<p class="ui-readable-width">
			Since feature flags <strong>decouple the concept of "deployment" from the concept of "release"</strong>, we <em>don't</em> have to modify any code and we <em>don't</em> have to deploy anything to production. All we have to do is revert the changes we made to the feature configuration.
		</p>

		<p class="ui-readable-width">
			Let's remove the rule that targeted the company subdomain, "dayknight", and which served up the second variant (<span class="u-variant-2">true</span>):
		</p>

		<cfmodule template="./snippet-1.cfm">

		<p class="ui-readable-width">
			When we make this change, the feature flag evaluations will be <em>instantaneously</em> reverted in our beta-tester's subdomain. Users under the subdomain "dayknight" will start receiving the first variant (<span class="u-variant-1">false</span>). Which means the old version of the feature will be rendered; and, no more data will be corrupted.
		</p>

		<form method="get">
			<input type="hidden" name="event" value="playground.walkthrough.step6c" />

			<button type="submit">
				Roll-Back the Changes &rarr;
			</button>
		</form>

		<cfmodule template="../shared/raw.cfm">

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../shared/targeting.cfm" step="6" highlightAssociation="production:3:2">

	</cfoutput>
</cfsavecontent>
