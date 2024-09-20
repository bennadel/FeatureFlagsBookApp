<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p class="ui-readable-width">
			We just created our new Boolean feature flag. It has two variants: <span class="variant-1">false</span> and <span class="variant-2">true</span>. By default, every user in every environment will receive the first variant (<span class="variant-1">false</span>). You can see this variant allocation over to the right&nbsp;&rarr;
		</p>

		<p class="ui-readable-width">
			While feature flags are shared across environments (development, staging, QA, integration, production, etc), each environment can be configured independently. This playground provides two environments: development and production.
		</p>

		<p class="ui-readable-width">
			To start developing our new feature, let's enable the feature flag in our development environment. To do this, we'll change the default <code>resolution</code> in our development environment to serve the second variant (<span class="variant-2">true</span>):
		</p>

		<cfmodule template="./snippet-1.cfm">

		<form method="get">
			<input type="hidden" name="event" value="playground.walkthrough.step3" />

			<button type="submit">
				Enable in Development Environment &rarr;
			</button>
		</form>

		<cfmodule template="../shared/raw.cfm">

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../shared/targeting.cfm" step="2">

	</cfoutput>
</cfsavecontent>
