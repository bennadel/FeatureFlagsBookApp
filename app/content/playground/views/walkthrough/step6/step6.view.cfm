<cfsavecontent variable="request.template.primaryContent">
	<style type="text/css">

		.uh-oh {
			border: 4px solid red ;
			padding: 21px 24px ;
			margin-top: 2rem ;
		}
		.uh-oh h2 {
			font-size: 1.3rem ;
		}

	</style>
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p class="ui-readable-width">
			As you can see on the right, the feature has been enabled for the "dayknight" subdomain. Now, in addition to using the new feature internally on your development team, you have real customers consuming it. This will almost certainly surface new bugs and usability issues. But, no worries&mdash;the vast majority of production users are still consuming the old version of the feature.
		</p>

		<p class="ui-readable-width">
			Once the beta testing period has concluded, we can start releasing this new feature to the general audience. But, we still want to be cautious. Instead of enabling the new feature for <em>everyone</em>, we're going to release is to 25% of the user-base.
		</p>

		<p class="ui-readable-width">
			To do this, we'll change the default resolution of the production environment to be a "distribution" that allocates the <span class="variant-2">true</span> variant to 25% of users:
		</p>

		<cfmodule template="./snippet-1.cfm">

		<form method="get">
			<input type="hidden" name="event" value="playground.walkthrough.step7" />

			<button type="submit">
				Enable for 25% of All Users &rarr;
			</button>
		</form>

		<div class="uh-oh u-collapse-margin ui-readable-width">
			<h2>
				Side Quest: A Critical Bug Is Discovered!
			</h2>

			<p>
				As a thought experiment, let's imagine that your beta-testing customer uncovered a critical bug in your new feature's implementation. Perhaps the text values are being truncated and the data is being corrupted! We need to prevent more errors from taking place.
			</p>

			<p>
				This is where feature flag really shine!
			</p>

			<p>
				<a href="/index.cfm?event=playground.walkthrough.step6b">Let's see what we can do</a> &rarr;
			</p>
		</div>

		<cfmodule template="../shared/raw.cfm">

	</cfoutput>
</cfsavecontent>

<cfsavecontent variable="request.template.asideContent">
	<cfoutput>

		<cfmodule template="../shared/targeting.cfm" step="6" highlightAssociation="production:3:2">

	</cfoutput>
</cfsavecontent>
