<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p class="ui-readable-width">
			Your customer discovered a critical bug that slipped past your development team. It's an unfortunate situation. But, feature flags can really help us out in this scenario.
		</p>

		<p class="ui-readable-width">
			Since feature flags allow us to decouple the concept of "deployment" from the concept of "release", we <em>don't</em> have to modify any code and we <em>don't</em> have to deploy anything to production. All we have to do is revert the changes we made to the feature configuration:
		</p>

		<cfmodule template="./snippet-1.cfm">

		<p class="ui-readable-width">
			When we make this change, the new feature will be <em>instantaneously</em> reverted in our beta-tester's subdomain. This means the old version of the feature will be rendered; and, no more data will be corrupted.
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
