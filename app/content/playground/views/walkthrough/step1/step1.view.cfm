<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<div class="ui-readable-width">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p>
				Feature flags completely transform the way you think about and approach product development. Instead of occasionally deploying large features to an entire user-base, you can incrementally build and gradually release a feature to an increasing number of users. To get a better sense of what this means, let's create and release a feature together.
			</p>

			<p>
				Our feature will replace plain-text inputs with rich-text components. Feature flag keys often include a ticket number that relates the work back to your company's product management software. In this case, we'll use, "TICKET-919".
			</p>

			<dl>
				<div>
					<dt>
						Feature:
					</dt>
					<dd>
						<mark>#encodeForHtml( request.featureKey )#</mark>
					</dd>
				</div>
				<div>
					<dt>
						Type:
					</dt>
					<dd>
						#encodeForHtml( request.feature.type )#
					</dd>
				</div>
				<div>
					<dt>
						Description:
					</dt>
					<dd class="u-no-inner-margin-y">
						<p>
							#encodeForHtml( request.feature.description )#
						</p>
					</dd>
				</div>
				<div>
					<dt>
						Variants:
					</dt>
					<dd class="u-no-inner-margin-y">
						<ul class="u-breathing-room">
							<cfloop array="#utilities.toEntries( request.feature.variants )#" index="entry">
								<li>
									<span class="ui-tag u-variant-#entry.index#">
										#encodeForHtml( serializeJson( entry.value ) )#
									</span>
								</li>
							</cfloop>
						</ul>
					</dd>
				</div>
			</dl>

			<form method="get">
				<input type="hidden" name="event" value="playground.walkthrough.step2" />
				<button type="submit">
					Create Feature Flag
				</button>
			</form>

		</div>

	</cfoutput>
</cfsavecontent>
