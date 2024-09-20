<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p class="ui-readable-width">
			As you can see on the right, the feature has been enabled for you and your entire development team. Now, it should be easy to find any remaining bugs and rough edges in your implementation. In no time, your new feature will be polished and ready for "release" to a broader audience.
		</p>

		<p class="ui-readable-width">
			But, before we start releasing the feature to the general audience, let's work with a customer who's signed-up to beta test new features. To do this, we'll add a new rule that targets customer's subdomain, "dayknight":
		</p>

		<cfmodule template="./snippet-1.cfm">

		<p class="ui-readable-width">
			Note that I could have combined the two rules that target "user.company.subdomain"; however, by keeping them separate, it makes it easier to highlight the incremental feature activation on the right.
		</p>

		<form method="get">
			<input type="hidden" name="event" value="playground.walkthrough.step6" />

			<button type="submit">
				Enable for Customer Team &rarr;
			</button>
		</form>

		<cfmodule template="../shared/raw.cfm">

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../shared/targeting.cfm" step="5" highlightAssociation="production:2:2">

	</cfoutput>
</cfsavecontent>
