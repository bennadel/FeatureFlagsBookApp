<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="content-wrapper u-collapse-margin">

			<h1>
				#encodeForHtml( partial.title )#
			</h1>

			<dl class="key-values">
				<div>
					<dt>
						<strong>Feature:</strong>
					</dt>
					<dd>
						#encodeForHtml( partial.feature.key )#
					</dd>
				</div>
				<div>
					<dt>
						<strong>Type:</strong>
					</dt>
					<dd>
						#encodeForHtml( partial.feature.type )#
					</dd>
				</div>
				<cfif partial.feature.description.len()>
					<div>
						<dt>
							<strong>Description:</strong>
						</dt>
						<dd>
							#encodeForHtml( partial.feature.description )#
						</dd>
					</div>
				</cfif>
				<div>
					<dt>
						<strong>Variants:</strong>
					</dt>
					<dd>
						<ol class="breathing-room">
							<cfloop index="entry" array="#utilities.toEntries( partial.feature.variants )#">
								<li>
									<span class="tag variant-#entry.index#">
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
				<input type="hidden" name="featureKey" value="#encodeForHtmlAttribute( partial.feature.key )#" />
				<input type="hidden" name="submitted" value="true" />

				<p>
					<button type="submit">
						Delete Feature Flag
					</button>
					<a href="/index.cfm?event=playground.features.detail.targeting&featureKey=#encodeForUrl( partial.feature.key )#">
						Cancel
					</a>
				</p>

			</form>

		</section>

	</cfoutput>
</cfsavecontent>
