<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p class="ui-readable-width">
			Amazing work! You've fully integrated your new feature and removed the now-unnecessary feature-gating. At this point, I invite you to start exploring the other feature flags in this playground. Click around, edit, delete, and have fun!
		</p>

		<h2>
			Feature Flags
		</h2>

		<ul>
			<cfloop array="#features#" index="feature">
				<li>
					<a href="/index.cfm?event=playground.features.detail.targeting&featureKey=#encodeForUrl( feature.key )#">#encodeForHtml( feature.key )#</a>
				</li>
			</cfloop>
		</ul>

		<p>
			And, if you're curious to see how the feature flag configuration data is stored, take a look at <a href="/index.cfm?event=playground.raw">the raw JSON</a>.
		</p>

	</cfoutput>
</cfsavecontent>
