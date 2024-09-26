<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="content-wrapper">

			<div class="ui-readable-width">

				<h1>
					#encodeForHtml( title )#
				</h1>

				<p>
					The variant allocation explanation provides insight into why a given user received a given feature flag variant within a given environment.
				</p>

				<dl>
					<div>
						<dt>
							User:
						</dt>
						<dd>
							<a href="/index.cfm?event=playground.staging.user&userID=#encodeForUrl( user.id )#">#encodeForHtml( user.email )#</a>
						</dd>
					</div>
					<div>
						<dt>
							Feature:
						</dt>
						<dd>
							<a href="/index.cfm?event=playground.features.detail.targeting&featureKey=#encodeForHtml( feature.key )###environment-#encodeForUrl( environment.key )#">#encodeForHtml( feature.key )#</a>
						</dd>
					</div>
					<div>
						<dt>
							Environment:
						</dt>
						<dd>
							<a href="/index.cfm?event=playground.staging.matrix###encodeForUrl( feature.key )#">#encodeForHtml( environment.key )#</a>
						</dd>
					</div>
					<div>
						<dt>
							Variant:
						</dt>
						<dd>
							<div class="ui-row">
								<span class="ui-row__item">
									<span class="ui-tag ui-variant-#result.variantIndex#">
										#encodeForHtml( serializeJson( result.variant ) )#
									</span>
								</span>

								<cfif ! result.variantIndex>
									<span class="ui-row__item">
										<cfif ( result.reason == "Error" )>
											&mdash; fallback value was used due to an error.
										<cfelse>
											&mdash; a custom variant was used.
										</cfif>
									</span>
								</cfif>
							</div>
						</dd>
					</div>
					<div>
						<dt>
							Reason:
						</dt>
						<dd>
							<cfif ( result.reason == "DefaultResolution" )>

								<a href="/index.cfm?event=playground.features.detail.defaultResolution&featureKey=#encodeForUrl( feature.key )#&environmentKey=#encodeForUrl( environment.key )#"><mark>#encodeForHtml( result.reason )#</mark></a>

								&mdash; the variant was allocated by the default resolution configured in the "#encodeForHtml( environment.key )#" environment. The default resolution was not overridden by any matching rules.

							<cfelseif result.matchingRuleIndex>

								<a href="/index.cfm?event=playground.features.detail.rule&featureKey=#encodeForUrl( feature.key )#&environmentKey=#encodeForUrl( environment.key )#&ruleIndex=#encodeForUrl( result.matchingRuleIndex )#"><mark>#encodeForHtml( result.reason )#</mark></a>

								&mdash; the variant was allocated by a matching rule configured in the "#encodeForHtml( environment.key )#" environment.

							<cfelse>

								<mark>#encodeForHtml( result.reason )#</mark>

							</cfif>
						</dd>
					</div>
				</dl>

			</div>

			<hr class="ui-rule" />

			<div class="ui-readable-width">

				<h2>
					User Inputs
				</h2>

				<p>
					Feature flag evaluation takes user inputs and processes them against a set of rules. The following user inputs were made available in this evaluation workflow.
				</p>

				<dl>
					<cfloop array="#utilities.toEntries( result.arguments.context )#" index="entry">
						<div>
							<dt>
								"#encodeForHtml( entry.key )#":
							</dt>
							<dd>
								#encodeForHtml( entry.value )#
							</dd>
						</div>
					</cfloop>
				</dl>

			</div>

			<hr class="ui-rule" />

			<div class="ui-readable-width">

				<h2>
					Evaluation Details
				</h2>

				<p>
					<mark>#encodeForHtml( result.reason )#</mark> &mdash;

					<cfswitch expression="#result.reason#">
						<!---
							Note: The two key-related cases aren't actually possible in this
							application (since the context objects are all being hard-coded in the
							application logic). But, I'm including them here for anyone that might
							view the source code and wants to better understand the targeting
							requirements for feature flag state evaluation.
						--->
						<cfcase value="MissingContextKey">
							your context struct must contain a `key` that associates the current request with a targetable entity (such as a user, machine host, ip address, application name, etc). Since you aren't providing a `key`, the fallback variant is being used.
						</cfcase>
						<cfcase value="ComplexContextKey">
							the context `key` property associated with the current request is a complex object and must be a simple value (string). This simple value is used to drive percent-based variant allocations and other targeting rules. Since you aren't providing a proper `key`, the fallback variant is being used.
						</cfcase>
						<!--- End: Cases that never happen in this app. --->
						<!---
							Note: Some of the following cases will never be experienced
							because a missing feature and/or environment will result in a page
							not found error before the evaluation can ever take place.
						--->
						<cfcase value="EmptyConfig">
							your configuration is empty (it has no feature flags). As such, the fallback variant is being used.
						</cfcase>
						<cfcase value="MissingFeature">
							your configuration does not contain the given feature key. As such, the fallback variant is being used.
						</cfcase>
						<cfcase value="MissingEnvironment">
							your configuration does not contain the given environment key. As such, the fallback variant is being used.
						</cfcase>
						<cfcase value="DefaultResolution">
							the variant was chosen using the environment's default resolution strategy.

							<cfif result.feature.targeting[ environment.key ].rulesEnabled>
								This is because no active rules matched against the given context.
							<cfelse>
								This is because rules are not enabled in the given environment.
							</cfif>
						</cfcase>
						<cfcase value="MatchingRule">
							a rule matched against the given context and provided an alternative resolution (one that overrode the environment's default resolution). The variant was chosen using this alternative resolution strategy.
						</cfcase>
						<cfcase value="Error">
							an unexpected error occurred. As such, the fallback variant is being used. <cfif result.errorMessage.len()>The error message: #encodeForHtml( result.errorMessage )#.</cfif>
						</cfcase>
						<cfdefaultcase>
							something unexpected happened. This state should not be possible.
						</cfdefaultcase>
					</cfswitch>
				</p>

				<cfif isStruct( result.resolution )>

					<h3>
						Resolution
					</h3>

					<p>
						The following resolution strategy was used to allocate the variant.
					</p>

					<dl>
						<div>
							<dt>
								Type:
							</dt>
							<dd>
								#encodeForHtml( result.resolution.type )#
							</dd>
						</div>
						<cfswitch expression="#result.resolution.type#">
							<cfcase value="selection">

								<div>
									<dt>
										<strong>Selection:</strong>
									</dt>
									<dd>
										<div class="ui-row">
											<span class="ui-row__item">
												#encodeForHtml( result.resolution.selection )#
											</span>
											<span class="ui-row__item">
												&rarr;
											</span>
											<span class="ui-row__item">
												<span class="ui-tag ui-variant-#result.variantIndex#">
													#encodeForHtml( serializeJson( feature.variants[ result.resolution.selection ] ) )#
												</span>
											</span>
										</div>
									</dd>
								</div>

							</cfcase>
							<cfcase value="distribution">

								<div>
									<dt>
										Distribution:
									</dt>
									<dd>

										<ul class="u-no-marker u-breathing-room">
											<cfloop array="#utilities.toEntries( result.resolution.distribution )#" index="entry">
												<li>

													<div class="ui-row">
														<span class="ui-row__item">
															#encodeForHtml( entry.value )#%
														</span>
														<span class="ui-row__item">
															&rarr;
														</span>
														<span class="ui-row__item">
															<span class="ui-tag ui-variant-#entry.index#">
																#encodeForHtml( serializeJson( feature.variants[ entry.index ] ) )#
															</span>
														</span>

														<cfif ( result.variantIndex == entry.index )>
															<span class="ui-row__item">
																&larr;
																<span>
																	allocated to user
																</span>
															</span>
														</cfif>
													</div>

												</li>
											</cfloop>
										</ul>

									</dd>
								</div>

							</cfcase>
							<cfcase value="variant">

								<div>
									<dt>
										Variant:
									</dt>
									<dd>

										<div class="ui-row">
											<span class="ui-row__item">
												<span class="ui-tag ui-variant-#result.variantIndex#">
													#encodeForHtml( serializeJson( result.variant ) )#
												</span>
											</span>
										</div>

									</dd>
								</div>

							</cfcase>
						</cfswitch>
					</dl>

				</cfif>


				<cfif ( result.reason == "MatchingRule" )>

					<cfset rule = result.evaluatedRules.last() />

					<h3>
						Matching Rule
					</h3>

					<p>
						The following rule matched against the user inputs and provided the resolution strategy above.
					</p>

					<dl>
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
							<dd class="ui-tag-list">
								<cfloop array="#rule.values#" index="value">
									<span class="ui-tag is-value">
										#encodeForHtml( serializeJson( value ) )#
									</span>
								</cfloop>
							</dd>
						</div>
						<div>
							<dt>
								Resolution:
							</dt>
							<dd>
								<em>See above</em>
							</dd>
						</div>
					</dl>

				</cfif>


				<cfif ( isArray( result.evaluatedRules ) && result.evaluatedRules.len() )>

					<h3>
						All Evaluated Rules
					</h3>

					<p>
						The following rules were all evaluated, in series, as part of the targeting workflow.

						<cfif ( result.reason == "MatchingRule" )>
							The last rule in this list is the one that matched against the user input; which short-circuited the evaluation process and resulted in the above rule selection.
						<cfelse>
							However, none of the rules matched; which is why the default resolution for this environment was ultimately used.
						</cfif>
					</p>

					<cfloop array="#utilities.toEntries( result.evaluatedRules )#" index="entry">

						<h4>
							<a href="/index.cfm?event=playground.features.detail.rule&featureKey=#encodeForUrl( feature.key )#&environmentKey=#encodeForUrl( environment.key )#&ruleIndex=#encodeForUrl( entry.key )#">Rule #numberFormat( entry.key )#</a>
						</h4>

						<cfif ( entry.key == result.matchingRuleIndex )>
							<p>
								This rule <mark><strong>matched</strong></mark> the provided context; and was used to resolve the feature flag evaluation.
							</p>
						<cfelse>
							<p>
								This rule <strong>did not match</strong> the provided context.
							</p>
						</cfif>

						<cfset rule = entry.value />

						<dl>
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
								<dd class="ui-tag-list">
									<cfloop array="#rule.values#" index="value">
										<span class="ui-tag is-value">
											#encodeForHtml( serializeJson( value ) )#
										</span>
									</cfloop>
								</dd>
							</div>
							<div>
								<dt>
									Resolution:
								</dt>
								<dd>
									#encodeForHtml( rule.resolution.type )#
								</dd>
							</div>

							<cfswitch expression="#rule.resolution.type#">
								<cfcase value="selection">

									<div>
										<dt>
											Selection:
										</dt>
										<dd>
											<div class="ui-row">
												<span class="ui-row__item">
													#encodeForHtml( rule.resolution.selection )#
												</span>
												<span class="ui-row__item">
													&rarr;
												</span>
												<span class="ui-row__item">
													<span class="ui-tag ui-variant-#result.variantIndex#">
														#encodeForHtml( serializeJson( feature.variants[ rule.resolution.selection ] ) )#
													</span>
												</span>
											</div>
										</dd>
									</div>

								</cfcase>
								<cfcase value="distribution">

									<div>
										<dt>
											Distribution:
										</dt>
										<dd>
											<ul class="u-no-marker u-breathing-room">
												<cfloop array="#utilities.toEntries( rule.resolution.distribution )#" index="entry">
													<li>
														<div class="ui-row">
															<span class="ui-row__item">
																#encodeForHtml( entry.value )#%
															</span>
															<span class="ui-row__item">
																&rarr;
															</span>
															<span class="ui-row__item">
																<span class="ui-tag ui-variant-#entry.index#">
																	#encodeForHtml( serializeJson( feature.variants[ entry.index ] ) )#
																</span>
															</span>
														</div>
													</li>
												</cfloop>
											</ul>
										</dd>
									</div>

								</cfcase>
								<cfcase value="variant">

									<div>
										<dt>
											Variant:
										</dt>
										<dd>
											<div class="ui-row">
												<span class="ui-row__item">
													<span class="ui-tag ui-variant-#result.variantIndex#">
														#encodeForHtml( serializeJson( result.variant ) )#
													</span>
												</span>
											</div>
										</dd>
									</div>

								</cfcase>
							</cfswitch>

						</dl>

					</cfloop>

				</cfif>

			</div>

			<!---
				While the evaluation process can skip-over rules to a mismatch in
				data-types, this isn't technically possible in this playground since
				the input / context objects are hard-coded.
			--->

		</section>

	</cfoutput>
</cfsavecontent>
