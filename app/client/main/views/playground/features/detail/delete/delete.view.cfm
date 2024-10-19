<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="ui-content-wrapper">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<dl class="ui-readable-width">
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
						Type:
					</dt>
					<dd>
						#encodeForHtml( feature.type )#
					</dd>
				</div>
				<cfif feature.description.len()>
					<div>
						<dt>
							Description:
						</dt>
						<dd>
							#encodeForHtml( feature.description )#
						</dd>
					</div>
				</cfif>
				<div>
					<dt>
						Variants:
					</dt>
					<dd>

						<ol class="u-breathing-room">
							<cfloop index="entry" array="#utilities.toEntries( feature.variants )#">
								<li>

									<div class="ui-row">
										<span class="ui-row__item">
											<span class="ui-tag ui-variant-#entry.index#">
												#encodeForHtml( serializeJson( entry.value ) )#
											</span>
										</span>
									</div>

								</li>
							</cfloop>
						</ol>

					</dd>
				</div>
			</dl>

			<cfmodule
				template="/client/main/tags/errorMessage.cfm"
				message="#errorMessage#"
				class="ui-readable-width"
			/>

			<form method="post" action="/index.cfm">
				<cfmodule template="/client/main/tags/event.cfm">
				<cfmodule template="/client/main/tags/xsrf.cfm">
				<input type="hidden" name="featureKey" value="#encodeForHtmlAttribute( feature.key )#" />

				<p class="ui-form-buttons ui-row">
					<span class="ui-row__item">
						<button type="submit" class="ui-button is-submit is-destructive">
							Delete Feature Flag
						</button>
					</span>
					<span class="ui-row__item">
						<a href="/index.cfm?event=playground.features.detail.targeting&featureKey=#encodeForUrl( feature.key )#" class="ui-button is-cancel">
							Cancel
						</a>
					</span>
				</p>

			</form>

		</section>

	</cfoutput>
</cfsavecontent>
