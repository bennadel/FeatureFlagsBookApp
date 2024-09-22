<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="content-wrapper">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<cfif errorMessage.len()>
				<p class="ui-error-message">
					#encodeForHtml( errorMessage )#
				</p>
			</cfif>

			<form method="post">
				<input type="hidden" name="event" value="#encodeForHtmlAttribute( request.context.event )#" />
				<input type="hidden" name="submitted" value="true" />

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
								size="40"
							/>
						</dd>
					</div>
					<div>
						<dt>
							Type:
						</dt>
						<dd>
							<cfloop index="featureType" array="#[ 'boolean', 'string', 'number' ]#">

								<label class="choggle">
									<input
										type="radio"
										name="type"
										value="#encodeForHtmlAttribute( featureType )#"
										#ui.attrChecked( form.type == featureType )#
										class="choggle__control"
									/>
									<span class="choggle__label">
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
							<textarea cols="50" rows="3">#encodeForHtml( form.description )#</textarea>
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

										<div class="choggle">
											<input
												type="text"
												name="variantsRaw[]"
												value="#encodeForHtmlAttribute( entry.value )#"
												size="30"
												class="choggle__control"
											/>
											<label class="choggle__label choggle">
												<input
													type="radio"
													name="defaultSelection"
													value="#encodeForHtmlAttribute( entry.index )#"
													#ui.attrChecked( form.defaultSelection == entry.index )#
													class="choggle__control"
												/>
												<span class="choggle__label">
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

				<p>
					<button type="submit">
						Create Feature
					</button>
					<a href="/index.cfm">
						Cancel
					</a>
				</p>

			</form>

		</section>

	</cfoutput>
</cfsavecontent>
