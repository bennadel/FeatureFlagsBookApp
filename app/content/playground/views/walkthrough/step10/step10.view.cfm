<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p class="ui-readable-width">
			Your feaure has been running in production for some period of time with no issues. It seems that customers are happy and the coast is clear. Time to clean-up after yourself. Remove the feature-gating logic from your code and then delete the feature flag configuration.
		</p>

		<form method="get">
			<input type="hidden" name="event" value="playground.walkthrough.step11" />

			<button type="submit">
				Delete Feature Flag
			</button>
		</form>

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../shared/targeting.cfm" step="10">

	</cfoutput>
</cfsavecontent>
