<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<div class="ui-readable-width">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p>
				With the recent feature flag configuration changes instantly reverted, your development team is now the only team receiving the <span class="ui-variant-2">true</span> variant in production. This simple action prevented new bugs from occurring; and buys your development team time to debug and correct the feature behavior.
			</p>

			<p>
				You didn't have to modify the code.
			</p>

			<p>
				You didn't have to deploy anything.
			</p>

			<p>
				You are freaking amazing!
			</p>

			<form method="get" action="/index.cfm">
				<input type="hidden" name="event" value="playground.walkthrough.step6" />

				<button type="submit" class="ui-button is-submit">
					Resume the Main Walk-Through &rarr;
				</button>
			</form>

		</div>

		<cfmodule template="../common/raw.cfm">

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../common/targeting.cfm" step="6" highlightAssociation="production:2:2">

	</cfoutput>
</cfsavecontent>
