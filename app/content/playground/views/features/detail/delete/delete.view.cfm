<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="content-wrapper u-collapse-margin">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<dl class="key-values">
				<div>
					<dt>
						<strong>Feature:</strong>
					</dt>
					<dd>
						#encodeForHtml( feature.key )#
					</dd>
				</div>
				<div>
					<dt>
						<strong>Type:</strong>
					</dt>
					<dd>
						#encodeForHtml( feature.type )#
					</dd>
				</div>
				<cfif feature.description.len()>
					<div>
						<dt>
							<strong>Description:</strong>
						</dt>
						<dd>
							#encodeForHtml( feature.description )#
						</dd>
					</div>
				</cfif>
				<div>
					<dt>
						<strong>Variants:</strong>
					</dt>
					<dd>
						<ol class="breathing-room">
							<cfloop index="entry" array="#utilities.toEntries( feature.variants )#">
								<li>
									<span class="tag u-variant-#entry.index#">
										#encodeForHtml( serializeJson( entry.value ) )#
									</span>
								</li>
							</cfloop>
						</ol>
					</dd>
				</div>
			</dl>

			<cfif errorMessage.len()>
				<p class="error-message">
					#encodeForHtml( errorMessage )#
				</p>
			</cfif>

			<form method="post">
				<input type="hidden" name="event" value="#encodeForHtmlAttribute( request.context.event )#" />
				<input type="hidden" name="featureKey" value="#encodeForHtmlAttribute( feature.key )#" />
				<input type="hidden" name="submitted" value="true" />

				<p>
					<button type="submit">
						Delete Feature Flag
					</button>
					<a href="/index.cfm?event=playground.features.detail.targeting&featureKey=#encodeForUrl( feature.key )#">
						Cancel
					</a>
				</p>

			</form>

		</section>

	</cfoutput>
</cfsavecontent>
