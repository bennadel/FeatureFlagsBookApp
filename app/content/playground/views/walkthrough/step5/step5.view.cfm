<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<div class="ui-readable-width">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p>
				As you can see on the right, the feature has been enabled for you and the rest of your development team. Now, it should be easy to find any remaining bugs and rough edges in your implementation. In no time, your new feature will be ready for "release" to a broader audience.
			</p>

			<h2>
				Next Step
			</h2>

			<p>
				Before we start releasing the feature to everyone, let's work with a customer who's signed-up to beta-test new features. To do this, we'll add a new rule that targets the customer's subdomain, "dayknight", and serves up the second variant (<span class="u-variant-2">true</span>):
			</p>

			<cfmodule template="./snippet-1.cfm">

			<p>
				Note that I could have combined the two rules that target "user.company.subdomain" and serve up the same variant; however, by keeping them separate in this walk-through, it makes it easier to highlight the incremental feature release on the right.
			</p>

			<form method="get">
				<input type="hidden" name="event" value="playground.walkthrough.step6" />

				<button type="submit">
					Enable for the Customer Team (dayknight) &rarr;
				</button>
			</form>

		</div>

		<cfmodule template="../shared/raw.cfm">

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../shared/targeting.cfm" step="5" highlightAssociation="production:2:2">

	</cfoutput>
</cfsavecontent>
