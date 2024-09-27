<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<div class="ui-readable-width">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p>
				Your new feature has been running in production for some period of time with no issues. It seems that the customers are happy and the coast is clear. It's time to clean-up after yourself.
			</p>

			<p>
				Leaving unnecessary feature flags in the code is a huge mistake. While feature flags are absolutely amazing, they do add complexity and increase the cost of maintenance. Feature flags should be removed from the code as soon as possible.
			</p>

			<h2>
				Next Step
			</h2>

			<p>
				Remove the feature-gating logic from the code and then delete the feature flag configuration:
			</p>

			<cfmodule template="./snippet-1.cfm">

			<form method="get" action="/index.cfm">
				<input type="hidden" name="event" value="playground.walkthrough.step11" />

				<button type="submit" class="ui-button is-submit">
					Delete Feature Flag &rarr;
				</button>
			</form>

		</div>

		<cfmodule template="../shared/raw.cfm">

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../shared/targeting.cfm" step="10">

	</cfoutput>
</cfsavecontent>
