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
						<strong>Environment:</strong>
					</dt>
					<dd>
						#encodeForHtml( partial.environment.key )#
					</dd>
				</div>
				<div>
					<dt>
						<strong>Input:</strong>
					</dt>
					<dd>
						"#encodeForHtml( partial.rule.input )#"
					</dd>
				</div>
				<div>
					<dt>
						<strong>Operator:</strong>
					</dt>
					<dd>
						#encodeForHtml( partial.rule.operator )#
					</dd>
				</div>
				<div>
					<dt>
						<strong>Values:</strong>
					</dt>
					<dd>
						<cfloop array="#partial.rule.values#" index="value">
							[#encodeForHtml( serializeJson( value ) )#]
						</cfloop>
					</dd>
				</div>
				<div>
					<dt>
						<strong>Resolution:</strong>
					</dt>
					<dd>
						<cfswitch expression="#partial.rule.resolution.type#">
							<cfcase value="selection">
								Selection &rarr;
								<span class="tag variant-#partial.rule.resolution.selection#">
									#encodeForHtml( serializeJson( partial.feature.variants[ partial.rule.resolution.selection ] ) )#
								</span>
							</cfcase>
							<cfcase value="distribution">
								<p>
									Distribution
								</p>
								<ul class="breathing-room">
									<cfloop index="entry" array="#utilities.toEntries( partial.rule.resolution.distribution )#">
										<cfif entry.value>
											<li>
												#encodeForHtml( entry.value )#% &rarr;
												<span class="tag variant-#entry.index#">
													#encodeForHtml( serializeJson( partial.feature.variants[ entry.index ] ) )#
												</span>
											</li>
										</cfif>
									</cfloop>
								</ul>
							</cfcase>
							<cfcase value="variant">
								Variant &rarr;
								<span class="tag variant-0">
									#encodeForHtml( serializeJson( partial.rule.resolution.variant ) )#
								</span>
							</cfcase>
						</cfswitch>
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
				<input type="hidden" name="environmentKey" value="#encodeForHtmlAttribute( partial.environment.key )#" />
				<input type="hidden" name="ruleIndex" value="#encodeForHtmlAttribute( request.context.ruleIndex )#" />
				<input type="hidden" name="submitted" value="true" />

				<p>
					<button type="submit">
						Delete Rule
					</button>
					<a href="/index.cfm?event=playground.features.detail.targeting&featureKey=#encodeForUrl( partial.feature.key )###environment-#encodeForUrl( partial.environment.key )#">
						Cancel
					</a>
				</p>

			</form>

		</section>

	</cfoutput>
</cfsavecontent>
