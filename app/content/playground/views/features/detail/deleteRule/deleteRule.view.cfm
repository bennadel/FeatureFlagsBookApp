<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="content-wrapper">

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
				<div>
					<dt>
						Input:
					</dt>
					<dd>
						"#encodeForHtml( rule.input )#"
					</dd>
				</div>
				<div>
					<dt>
						Operator:
					</dt>
					<dd>
						#encodeForHtml( rule.operator )#
					</dd>
				</div>
				<div>
					<dt>
						Values:
					</dt>
					<dd>
						<cfloop array="#rule.values#" index="value">
							[#encodeForHtml( serializeJson( value ) )#]
						</cfloop>
					</dd>
				</div>
				<div>
					<dt>
						Resolution:
					</dt>
					<dd>
						<cfswitch expression="#rule.resolution.type#">
							<cfcase value="selection">
								Selection &rarr;
								<span class="ui-tag u-variant-#rule.resolution.selection#">
									#encodeForHtml( serializeJson( feature.variants[ rule.resolution.selection ] ) )#
								</span>
							</cfcase>
							<cfcase value="distribution">
								<p>
									Distribution
								</p>
								<ul class="u-breathing-room">
									<cfloop index="entry" array="#utilities.toEntries( rule.resolution.distribution )#">
										<cfif entry.value>
											<li>
												#encodeForHtml( entry.value )#% &rarr;
												<span class="ui-tag u-variant-#entry.index#">
													#encodeForHtml( serializeJson( feature.variants[ entry.index ] ) )#
												</span>
											</li>
										</cfif>
									</cfloop>
								</ul>
							</cfcase>
							<cfcase value="variant">
								Variant &rarr;
								<span class="ui-tag u-variant-0">
									#encodeForHtml( serializeJson( rule.resolution.variant ) )#
								</span>
							</cfcase>
						</cfswitch>
					</dd>
				</div>
			</dl>

			<cfif errorMessage.len()>
				<p class="ui-error-message">
					#encodeForHtml( errorMessage )#
				</p>
			</cfif>

			<form method="post">
				<input type="hidden" name="event" value="#encodeForHtmlAttribute( request.context.event )#" />
				<input type="hidden" name="featureKey" value="#encodeForHtmlAttribute( feature.key )#" />
				<input type="hidden" name="environmentKey" value="#encodeForHtmlAttribute( environment.key )#" />
				<input type="hidden" name="ruleIndex" value="#encodeForHtmlAttribute( ruleIndex )#" />
				<input type="hidden" name="submitted" value="true" />

				<p>
					<button type="submit">
						Delete Rule
					</button>
					<a href="/index.cfm?event=playground.features.detail.targeting&featureKey=#encodeForUrl( feature.key )###environment-#encodeForUrl( environment.key )#">
						Cancel
					</a>
				</p>

			</form>

		</section>

	</cfoutput>
</cfsavecontent>
