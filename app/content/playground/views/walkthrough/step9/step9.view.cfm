<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p class="ui-readable-width">
			You just developed and progressively launched a new feature using feature flags! So safe, so easy, so rewarding! Time to let the feature soak in production for some period of time.
		</p>

		<form method="get">
			<input type="hidden" name="event" value="playground.walkthrough.step10" />

			<button type="submit">
				Let it Soak in Production
			</button>
		</form>

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../shared/targeting.cfm" step="9" highlightAssociation="production:0:2">

	</cfoutput>
</cfsavecontent>
