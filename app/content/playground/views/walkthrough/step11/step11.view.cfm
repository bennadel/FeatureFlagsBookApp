<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p class="ui-readable-width">
			Amazing work! You've fully integrated your new feature and removed the feature code. At this point, you can start exploring the other feature flags in this playground app:
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

	</cfoutput>
</cfsavecontent>
