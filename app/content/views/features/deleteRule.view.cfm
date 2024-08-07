<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			&larr; <a href="/index.cfm?event=features.targeting&featureKey=#encodeForUrl( feature.key )###environment-#encodeForUrl( targeting.key )#">Back to Targeting</a>
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
					<strong>Environment:</strong>
				</dt>
				<dd>
					#encodeForHtml( targeting.key )#
				</dd>
			</div>
			<div>
				<dt>
					<strong>Input:</strong>
				</dt>
				<dd>
					"#encodeForHtml( rule.input )#"
				</dd>
			</div>
			<div>
				<dt>
					<strong>Operator:</strong>
				</dt>
				<dd>
					#encodeForHtml( rule.operator )#
				</dd>
			</div>
			<div>
				<dt>
					<strong>Values:</strong>
				</dt>
				<dd>
					<cfloop index="value" array="#rule.values#">
						[#encodeForHtml( serializeJson( value ) )#]
					</cfloop>
				</dd>
			</div>
			<div>
				<dt>
					<strong>Resolution:</strong>
				</dt>
				<dd>
					<cfswitch expression="#rule.resolution.type#">
						<cfcase value="selection">
							Selection &rarr;
							<span class="tag variant-#rule.resolution.selection#">
								#encodeForHtml( serializeJson( feature.variants[ rule.resolution.selection ] ) )#
							</span>
						</cfcase>
						<cfcase value="distribution">
							<p>
								Distribution
							</p>
							<ul class="breathing-room">
								<cfloop index="entry" array="#utilities.toEntries( rule.resolution.distribution )#">
									<cfif entry.value>
										<li>
											#encodeForHtml( entry.value )#% &rarr;
											<span class="tag variant-#entry.index#">
												#encodeForHtml( serializeJson( feature.variants[ entry.index ] ) )#
											</span>
										</li>
									</cfif>
								</cfloop>
							</ul>
						</cfcase>
						<cfcase value="variant">
							Variant &rarr;
							<span class="tag variant-0">
								#encodeForHtml( serializeJson( rule.resolution.variant ) )#
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
			<input type="hidden" name="featureKey" value="#encodeForHtmlAttribute( request.context.featureKey )#" />
			<input type="hidden" name="environmentKey" value="#encodeForHtmlAttribute( request.context.environmentKey )#" />
			<input type="hidden" name="ruleIndex" value="#encodeForHtmlAttribute( request.context.ruleIndex )#" />
			<input type="hidden" name="submitted" value="true" />

			<p>
				<button type="submit">
					Delete Rule
				</button>
				<a href="/index.cfm?event=features.targeting&featureKey=#encodeForUrl( feature.key )###environment-#encodeForUrl( targeting.key )#">
					Cancel
				</a>
			</p>

		</form>

	</cfoutput>
</cfsavecontent>
