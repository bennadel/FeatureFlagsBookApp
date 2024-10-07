<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<div class="ui-readable-width">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p>
				We just created our new Boolean feature flag. It has two variants: <span class="ui-variant-1">false</span> and <span class="ui-variant-2">true</span>. By default, every user in every environment will receive the first variant (<span class="ui-variant-1">false</span>). You can see this variant allocation over to the right&nbsp;&rarr;
			</p>

			<p>
				While feature flags are shared across environments (development, staging, QA, integration, production, etc), each environment can be configured independently. This playground provides two environments: development and production.
			</p>

			<h2>
				Next Step
			</h2>

			<p>
				To start developing our new feature, let's enable the feature flag in our development environment. To do this, we'll change the default <code>resolution</code> in our development environment to serve the second variant (<span class="ui-variant-2">true</span>):
			</p>

			<cfmodule template="./snippet-1.cfm">

			<form method="get" action="/index.cfm">
				<input type="hidden" name="event" value="playground.walkthrough.step3" />

				<button type="submit" class="ui-button is-submit">
					Enable in Development Environment &rarr;
				</button>
			</form>

		</div>

		<cfmodule template="../common/raw.cfm">

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../common/targeting.cfm" step="2">

	</cfoutput>
</cfsavecontent>
