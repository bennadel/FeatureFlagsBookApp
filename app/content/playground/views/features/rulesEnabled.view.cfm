<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			&larr; <a href="/index.cfm?event=playground.features.targeting&featureKey=#encodeForUrl( feature.key )###environment-#encodeForUrl( targeting.key )#">Back to Targeting</a>
		</p>

		<dl class="key-values key-values--static">
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
					<strong>Environment:</strong>
				</dt>
				<dd>
					#encodeForHtml( targeting.key )#
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
			<input type="hidden" name="environmentKey" value="#encodeForHtmlAttribute( request.context.environmentKey )#" />
			<input type="hidden" name="submitted" value="true" />

			<dl class="key-values">
				<div>
					<dt>
						<strong>Rules Evaluation:</strong>
					</dt>
					<dd>
						<label for="form--disabled" class="choggle">
							<input
								id="form--disabled"
								type="radio"
								name="rulesEnabled"
								value="false"
								<cfif ! form.rulesEnabled>
									checked
								</cfif>
								class="choggle__control"
							/>
							<span class="choggle__label">
								Disabled
							</span>
						</label>
						<label for="form--enabled" class="choggle">
							<input
								id="form--enabled"
								type="radio"
								name="rulesEnabled"
								value="true"
								<cfif form.rulesEnabled>
									checked
								</cfif>
								class="choggle__control"
							/>
							<span class="choggle__label">
								Enabled
							</span>
						</label>
					</dd>
				</div>
			</dl>

			<p>
				<button type="submit">
					Save
				</button>
				<a href="/index.cfm?event=playground.features.targeting&featureKey=#encodeForUrl( feature.key )###environment-#encodeForUrl( targeting.key )#">
					Cancel
				</a>
			</p>

		</form>

	</cfoutput>
</cfsavecontent>
