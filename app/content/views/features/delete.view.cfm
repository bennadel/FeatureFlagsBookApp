<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			&larr; <a href="/index.cfm?event=features.targeting&featureKey=#encodeForUrl( feature.key )#">Back to Targeting</a>
		</p>

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
					<ol>
						<cfloop index="entry" array="#utilities.toEntries( feature.variants )#">
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
			<input type="hidden" name="featureKey" value="#encodeForHtmlAttribute( request.context.featureKey )#" />
			<input type="hidden" name="submitted" value="true" />

			<p>
				<button type="submit">
					Delete Feature Flag
				</button>
				<a href="/index.cfm?event=features.targeting&featureKey=#encodeForUrl( feature.key )#">
					Cancel
				</a>
			</p>

		</form>

	</cfoutput>
</cfsavecontent>
