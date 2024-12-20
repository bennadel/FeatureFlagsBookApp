<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="ui-content-wrapper">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<cfmodule
				template="/client/main/tags/errorMessage.cfm"
				message="#errorMessage#"
				class="ui-readable-width"
			/>

			<form method="post" action="/index.cfm">
				<cfmodule template="/client/main/tags/event.cfm">
				<cfmodule template="/client/main/tags/xsrf.cfm">

				<dl>
					<div>
						<dt>
							Key:
						</dt>
						<dd>
							<input
								type="text"
								name="featureKey"
								value="#encodeForHtmlAttribute( form.featureKey )#"
								maxlength="50"
								class="ui-input is-large"
							/>

							<p>
								The key can only contain letters, numbers, dashes, and underscores.
							</p>
						</dd>
					</div>
					<div>
						<dt>
							Type:
						</dt>
						<dd>
							<cfloop index="featureType" array="#[ 'boolean', 'string', 'number' ]#">

								<label class="ui-row">
									<span class="ui-row__item">
										<input
											type="radio"
											name="type"
											value="#encodeForHtmlAttribute( featureType )#"
											#ui.attrChecked( form.type == featureType )#
											class="ui-radio"
										/>
									</span>
									<span class="ui-row__item">
										#encodeForHtml( featureType )#
									</span>
								</label>

							</cfloop>

							<p>
								Note: I'm omitting the "any" type in order to keep things simple.
							</p>
						</dd>
					</div>
					<div>
						<dt>
							Description:
						</dt>
						<dd>
							<textarea
								name="description"
								maxlength="255"
								class="ui-textarea"
								>#encodeForHtml( form.description )#</textarea>
						</dd>
					</div>
					<div>
						<dt>
							Variants:
						</dt>
						<dd class="u-no-inner-margin-y">
							<ol class="u-breathing-room">
								<cfloop index="entry" array="#utilities.toEntries( form.variantsRaw )#">
									<li>

										<div class="ui-row">
											<span class="ui-row__item">
												<input
													type="text"
													name="variantsRaw[]"
													value="#encodeForHtmlAttribute( entry.value )#"
													size="30"
													class="ui-input"
												/>
											</span>
											<label class="ui-row__item ui-row">
												<span class="ui-row__item">
													<input
														type="radio"
														name="defaultSelection"
														value="#encodeForHtmlAttribute( entry.index )#"
														#ui.attrChecked( form.defaultSelection == entry.index )#
														class="ui-radio"
													/>
												</span>
												<span class="ui-row__item">
													Use as default.
												</span>
											</label>
										</div>

									</li>
								</cfloop>
							</ol>
						</dd>
					</div>
				</dl>

				<p class="ui-form-buttons ui-row">
					<span class="ui-row__item">
						<button type="submit" class="ui-button is-submit">
							Create Feature
						</button>
					</span>
					<span class="ui-row__item">
						<a href="/index.cfm" class="ui-button is-cancel">
							Cancel
						</a>
					</span>
				</p>

			</form>

		</section>

	</cfoutput>
</cfsavecontent>
