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
						Rules:
					</dt>
					<dd>
						<p>
							The following rules will be removed from this feature flag. After this, all targeting will be performed by the default resolution within each environment.
						</p>

						<ul>
							<cfloop array="#environments#" index="environment">
								<li>
									#encodeForHtml( environment.name )#
									&rarr;
									#numberFormat( feature.targeting[ environment.key ].rules.len() )# rule(s).
								</li>
							</cfloop>
						</ul>
					</dd>
				</div>
			</dl>

			<cfif errorMessage.len()>
				<p class="ui-error-message ui-readable-width">
					#encodeForHtml( errorMessage )#
				</p>
			</cfif>

			<form method="post" action="/index.cfm">
				<input type="hidden" name="event" value="#encodeForHtmlAttribute( request.context.event )#" />
				<input type="hidden" name="featureKey" value="#encodeForHtmlAttribute( feature.key )#" />
				<cfmodule template="/client/main/tags/xsrf.cfm">

				<p class="ui-form-buttons ui-row">
					<span class="ui-row__item">
						<button type="submit" class="ui-button is-submit is-destructive">
							Clear Feature Flag
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
