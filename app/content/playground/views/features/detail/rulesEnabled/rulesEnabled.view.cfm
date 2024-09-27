<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="ui-content-wrapper">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<dl>
				<div>
					<dt>
						Feature:
					</dt>
					<dd>
						#encodeForHtml( feature.key )#
					</dd>
				</div>
				<div>
					<dt>
						Environment:
					</dt>
					<dd>
						#encodeForHtml( environment.key )#
					</dd>
				</div>
			</dl>

			<hr class="ui-rule is-soft" />

			<cfif errorMessage.len()>
				<p class="ui-error-message">
					#encodeForHtml( errorMessage )#
				</p>
			</cfif>

			<form method="post">
				<input type="hidden" name="event" value="#encodeForHtmlAttribute( request.context.event )#" />
				<input type="hidden" name="featureKey" value="#encodeForHtmlAttribute( feature.key )#" />
				<input type="hidden" name="environmentKey" value="#encodeForHtmlAttribute( environment.key )#" />
				<input type="hidden" name="submitted" value="true" />
				<input type="hidden" name="x-xsrf-token" value="#encodeForHtmlAttribute( request.xsrfToken  )#" />

				<dl>
					<div>
						<dt>
							Evaluate Rules:
						</dt>
						<dd class="u-breathing-room">
							<label for="form--disabled" class="ui-row">
								<span class="ui-row__item">
									<input
										id="form--disabled"
										type="radio"
										name="rulesEnabled"
										value="false"
										#ui.attrChecked( ! form.rulesEnabled )#
										class="ui-radio"
									/>
								</span>
								<span class="ui-row__item">
									No &mdash; only the default resolution should be used.
								</span>
							</label>
							<label for="form--enabled" class="ui-row">
								<span class="ui-row__item">
									<input
										id="form--enabled"
										type="radio"
										name="rulesEnabled"
										value="true"
										#ui.attrChecked( form.rulesEnabled )#
										class="ui-radio"
									/>
								</span>
								<span class="ui-row__item">
									Yes &mdash; allow default resolution to be overridden by matching rule.
								</span>
							</label>
						</dd>
					</div>
				</dl>

				<p class="ui-form-buttons ui-row">
					<span class="ui-row__item">
						<button type="submit" class="ui-button is-submit">
							Save
						</button>
					</span>
					<span class="ui-row__item">
						<a href="/index.cfm?event=playground.features.detail.targeting&featureKey=#encodeForUrl( feature.key )###environment-#encodeForUrl( environment.key )#" class="ui-button is-cancel">
							Cancel
						</a>
					</span>
				</p>

			</form>

		</section>

	</cfoutput>
</cfsavecontent>
