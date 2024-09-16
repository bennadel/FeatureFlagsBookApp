<cfsavecontent variable="request.template.primaryContent">
	<style type="text/css">

		.feature {}

		.feature__header {
			background-color: #ffffff ;
			border-bottom: 2px solid #333333 ;
			display: flex ;
			font-weight: 400 ;
			margin: 40px 0 0 0 ;
			position: sticky ;
			top: 0px ;
			z-index: 2 ;
		}
		.feature__label {
			background-color: #333333 ;
			border-top-right-radius: 3px ;
			color: #ffffff ;
			padding: 10px 30px 4px 22px ;
		}
		.feature__body {
			border: 2px solid #333333 ;
			padding: 20px ;
		}

		.environment-key {
			margin-top: 30px ;
		}

		.state {
			display: flex ;
			flex-wrap: wrap ;
			gap: 1px ;
		}
		.state a {
			padding: 9px 15px 8px ;
			text-decoration: none ;
		}
		.state a:hover {
			text-decoration: underline ;
		}

	</style>
	<cfoutput>

		<section class="content-wrapper u-collapse-margin">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p>
				The following provides an overview of the feature flag variant values being allocated to the demo users across the various environments. You can click on any given variant to see an explanation as to why that variant has been chosen.
			</p>

			<ul>
				<cfloop array="#features#" index="feature">
					<li>
						<a href="###encodeForUrl( feature.key )#">#encodeForHtml( feature.key )#</a>
					</li>
				</cfloop>
			</ul>

			<cfloop array="#features#" index="feature">

				<article id="#encodeForHtmlAttribute( feature.key )#" class="feature">

					<h2 class="feature__header">
						<a href="/index.cfm?event=playground.features.detail.targeting&featureKey=#encodeForUrl( feature.key )#" class="feature__label">#encodeForHtml( feature.key )#</a>
					</h2>

					<div class="feature__body u-collapse-margin">

						<cfif feature.description.len()>
							<p>
								#encodeForHtml( feature.description )#
							</p>
						</cfif>

						<cfloop array="#environments#" index="environment">

							<h3 class="environment-key">
								<a href="/index.cfm?event=playground.features.detail.targeting&featureKey=#encodeForUrl( feature.key )###environment-#encodeForUrl( environment.key )#">#encodeForHtml( environment.key )#</a>
							</h3>

							<div class="state">
								<cfloop array="#users#" index="user">

									<cfset result = results[ feature.key ][ environment.key ][ user.id ] />

									<a href="/index.cfm?event=playground.staging.explain&userID=#encodeForUrl( user.id )#&featureKey=#encodeForUrl( feature.key )#&environmentKey=#encodeForUrl( environment.key )#&from=staging"
										class="variant-#result.variantIndex#">
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