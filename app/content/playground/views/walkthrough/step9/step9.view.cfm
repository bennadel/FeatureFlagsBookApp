<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p class="ui-readable-width">
			As you can see on the right, the new feature is now enabled for all users in the production environment. Congratulations, you just progressively developed and deployed a new feature with unparalleled safety. At this point, we can let the feature "soak" in production for some period of time, leaving the feature flag in case of emergency.
		</p>

		<p class="ui-readable-width">
			We could leave the distribution allocation at 100% while the feature soaks. But, for the sake of experience, let's delete the rules and update the default resolution in the production environment to serve up the second variant (<span class="variant-2">true</span>):
		</p>

		<cfmodule template="./snippet-1.cfm">

		<form method="get">
			<input type="hidden" name="event" value="playground.walkthrough.step10" />

			<button type="submit">
				Let it Soak in Production &rarr;
			</button>
		</form>

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../shared/targeting.cfm" step="9" highlightAssociation="production:0:2">

	</cfoutput>
</cfsavecontent>
