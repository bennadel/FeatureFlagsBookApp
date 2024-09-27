<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="ui-content-wrapper">

			<div class="ui-readable-width">

				<h1>
					#encodeForHtml( title )#
				</h1>

				<p>
					The feature matrix provides an overview of all the feature flag variant values being allocated to the demo users across the various environments. Each variant box below represents a user-variant allocation. You can click on any given box to view an explanation as to why that variant has been allocated for that user.
				</p>

				<h2>
					Feature Flags
				</h2>

				<ul>
					<cfloop array="#features#" index="feature">
						<li>
							<a href="###encodeForUrl( feature.key )#">#encodeForHtml( feature.key )#</a>
						</li>
					</cfloop>
				</ul>

			</div>

			<cfloop array="#features#" index="feature">

				<article id="#encodeForHtmlAttribute( feature.key )#" class="ui-folder">

					<h2 class="ui-folder__header">
						<a href="/index.cfm?event=playground.features.detail.targeting&featureKey=#encodeForUrl( feature.key )#" class="ui-folder__tab">
							#encodeForHtml( feature.key )#
						</a>
					</h2>

					<div class="ui-folder__main">

						<cfif feature.description.len()>
							<p class="ui-readable-width">
								#encodeForHtml( feature.description )#
							</p>
						</cfif>

						<cfloop array="#environments#" index="environment">

							<h3>
								<a href="/index.cfm?event=playground.features.detail.targeting&featureKey=#encodeForUrl( feature.key )###environment-#encodeForUrl( environment.key )#">#encodeForHtml( environment.name )#</a>
							</h3>

							<div m-a349b4 class="state">
								<cfloop array="#users#" index="user">

									<cfset result = results[ feature.key ][ environment.key ][ user.id ] />

									<a href="/index.cfm?event=playground.staging.explain&userID=#encodeForUrl( user.id )#&featureKey=#encodeForUrl( feature.key )#&environmentKey=#encodeForUrl( environment.key )#&from=staging"
										class="ui-variant-#result.variantIndex#">
										#encodeForHtml( serializeJson( result.variant ) )#
									</a>
								</cfloop>
							</div>

						</cfloop>

					</div>

				</article>

			</cfloop>

		</section>

	</cfoutput>
</cfsavecontent>
