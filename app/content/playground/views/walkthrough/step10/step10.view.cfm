<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p class="ui-readable-width">
			Your new feaure has been running in production for some period of time with no issues. It seems that the customers are happy and the coast is clear. It's time to clean-up after yourself (reducing complexity in the code). Remove the feature-gating logic from the code and then delete the feature flag configuration:
		</p>

		<cfmodule template="./snippet-1.cfm">

		<form method="get">
			<input type="hidden" name="event" value="playground.walkthrough.step11" />

			<button type="submit">
				Delete Feature Flag &rarr;
			</button>
		</form>

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../shared/targeting.cfm" step="10">

	</cfoutput>
</cfsavecontent>
