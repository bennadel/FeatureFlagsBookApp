<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>
		<!--- These power the mouseenter/mouseleave highlights of the evaluations. --->
		<style type="text/css">
			.flasher-distal {
				transition: opacity 300ms ease-out ;
			}

			<cfloop array="#environments#" index="environment">
				<cfloop from="0" to="20" index="i">

					.flash-root[data-flash-environment="#environment.key#"][data-flash-rule="#i#"]
						.flasher-proximal[data-flash-environment="#environment.key#"][data-flash-rule="#i#"] {
							border-radius: 1px ;
							outline: 1px dashed deeppink ;
							outline-offset: 4px ;
						}

					.flash-root[data-flash-source="distal"][data-flash-environment="#environment.key#"][data-flash-rule="#i#"]
						.flasher-proximal[data-flash-environment="#environment.key#"][data-flash-rule="#i#"] {
							animation: 500ms infinite m-a0f59c-proximal-animated ;
							outline: 2px solid deeppink ;
						}

					.flash-root[data-flash-environment="#environment.key#"][data-flash-rule="#i#"]
						.flasher-distal:not([data-flash-environment="#environment.key#"][data-flash-rule="#i#"]) {
							opacity: 0.2 ;
						}

				</cfloop>
			</cfloop>
		</style>
	</cfoutput>
	<cfoutput>

		<div x-data="ma0f59c.FlashRoot" m-a0f59c class="panels flash-root">
			<section m-a0f59c class="panels__main content-wrapper">

				<div class="ui-readable-width">

					<h1>
						#encodeForHtml( title )#
					</h1>

					<dl>
						<div>
							<dt>
								Key:
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
									<cfloop index="variantEntry" array="#utilities.toEntries( feature.variants )#">
										<li>

											<div class="u-flex-row">
												<span class="ui-tag ui-variant-#variantEntry.index#">
													#encodeForHtml( serializeJson( variantEntry.value ) )#
												</span>
											</div>

										</li>
									</cfloop>
								</ol>

							</dd>
						</div>
					</dl>

				</div>

				<cfloop array="#environments#" index="environment">

					<cfset settings = feature.targeting[ environment.key ] />

					<div id="environment-#encodeForHtmlAttribute( environment.key )#" class="ui-folder">
						<h2 class="ui-folder__header">
							<span class="ui-folder__tab">
								#encodeForHtml( environment.name )# Environment
							</span>
						</h2>
						<div class="ui-folder__main">

							<dl>
								<div
									@mouseenter="flashProximal( '#encodeForJavaScript( environment.key )#' )"
									@mouseleave="unflash()"
									data-flash-environment="#encodeForHtmlAttribute( environment.key )#"
									data-flash-rule="0"
									class="flasher-proximal">
									<dt x-data="ma0f59c.Editable" @click="handleClick()" m-a0f59c class="editable">
										Default Resolution:

										<a
											href="/index.cfm?event=playground.features.detail.defaultResolution&featureKey=#encodeForUrl( feature.key )#&environmentKey=#encodeForUrl( environment.key )#"
											x-ref="edit"
											m-a0f59c
											class="editable__link">
											Edit
										</a>
									</dt>
									<dd>
										<cfswitch expression="#settings.resolution.type#">
											<cfcase value="selection">
												<div class="u-flex-row">
													<span>
														Selection
													</span>
													&rarr;
													<span class="ui-tag ui-variant-#settings.resolution.selection#">
														#encodeForHtml( serializeJson( feature.variants[ settings.resolution.selection ] ) )#
													</span>
												</div>
											</cfcase>
											<cfcase value="distribution">
												<p>
													Distribution
												</p>
												<ul class="u-breathing-room">
													<cfloop index="distributionEntry" array="#utilities.toEntries( settings.resolution.distribution )#">
														<cfif distributionEntry.value>
															<li>
																<div class="u-flex-row">
																	<span>
																		#distributionEntry.value#%
																	</span>
																	&rarr;
																	<span class="ui-tag ui-variant-#distributionEntry.index#">
																		#encodeForHtml( serializeJson( feature.variants[ distributionEntry.index ] ) )#
																	</span>
																</div>
															</li>
														</cfif>
													</cfloop>
												</ul>
											</cfcase>
											<cfcase value="variant">
												<p class="u-flex-row">
													<span>
														Variant
													</span>
													&rarr;
													<span class="ui-tag ui-variant-0">
														#encodeForHtml( serializeJson( settings.resolution.variant ) )#
													</span>
												</p>
											</cfcase>
										</cfswitch>
									</dd>
								</div>
								<div>
									<dt x-data="ma0f59c.Editable" @click="handleClick()" m-a0f59c class="editable">
										Rules Enabled:

										<a
											href="/index.cfm?event=playground.features.detail.rulesEnabled&featureKey=#encodeForUrl( feature.key )#&environmentKey=#encodeForUrl( environment.key )#"
											x-ref="edit"
											m-a0f59c
											class="editable__link">
											Edit
										</a>
									</dt>
									<dd>
										<p>
											#yesNoFormat( settings.rulesEnabled )#
										</p>
									</dd>
								</div>
								<div>
									<dt>
										Rules:
									</dt>
									<dd>
										<cfloop index="ruleEntry" array="#utilities.toEntries( settings.rules )#">

											<cfset rule = ruleEntry.value />

											<dl
												@mouseenter="flashProximal( '#encodeForJavaScript( environment.key )#', '#ruleEntry.index#', #serializeJson( ! settings.rulesEnabled )# )"
												@mouseleave="unflash()"
												data-flash-environment="#encodeForHtmlAttribute( environment.key )#"
												data-flash-rule="#encodeForHtmlAttribute( ruleEntry.index )#"
												m-a0f59c
												class="rule <cfif ! settings.rulesEnabled>rule--disabled</cfif> flasher-proximal">
												<div>
													<dt x-data="ma0f59c.Editable" @click="handleClick()" m-a0f59c class="editable">
														IF:

														<a
															href="/index.cfm?event=playground.features.detail.rule&featureKey=#encodeForUrl( feature.key )#&environmentKey=#encodeForUrl( environment.key )#&ruleIndex=#encodeForUrl( ruleEntry.index )#"
															x-ref="edit"
															m-a0f59c
															class="editable__link">
															Edit
														</a>
														<a
															href="/index.cfm?event=playground.features.detail.deleteRule&featureKey=#encodeForUrl( feature.key )#&environmentKey=#encodeForUrl( environment.key )#&ruleIndex=#encodeForUrl( ruleEntry.index )#"
															m-a0f59c
															class="editable__link">
															Delete
														</a>
													</dt>
													<dd>
														"#encodeForHtml( rule.input )#"
													</dd>
												</div>
												<div>
													<dt>
														#encodeForHtml( rule.operator )#:
													</dt>
													<dd>
														<p class="ui-tag-list">
															<cfloop index="value" array="#rule.values#">
																<span class="ui-tag is-value">
																	#encodeForHtml( serializeJson( value ) )#
																</span>
															</cfloop>
														</p>
													</dd>
												</div>
												<div>
													<dt>
														Serve:
													</dt>
													<dd>
														<cfswitch expression="#rule.resolution.type#">
															<cfcase value="selection">
																<p class="u-flex-row">
																	<span>
																		Selection
																	</span>
																	&rarr;
																	<span class="ui-tag ui-variant-#rule.resolution.selection#">
																		#encodeForHtml( serializeJson( feature.variants[ rule.resolution.selection ] ) )#
																	</span>
																</p>
															</cfcase>
															<cfcase value="distribution">
																<p>
																	Distribution
																</p>
																<ul class="u-breathing-room">
																	<cfloop index="distributionEntry" array="#utilities.toEntries( rule.resolution.distribution )#">
																		<cfif distributionEntry.value>
																			<li>
																				<div class="u-flex-row">
																					<span>
																						#distributionEntry.value#%
																					</span>
																					&rarr;
																					<span class="ui-tag ui-variant-#distributionEntry.index#">
																						#encodeForHtml( serializeJson( feature.variants[ distributionEntry.index ] ) )#
																					</span>
																				</div>
																			</li>
																		</cfif>
																	</cfloop>
																</ul>
															</cfcase>
															<cfcase value="variant">
																<p class="u-flex-row">
																	<span>
																		Variant
																	</span>
																	&rarr;
																	<span class="ui-tag ui-variant-0">
																		#encodeForHtml( serializeJson( rule.resolution.variant ) )#
																	</span>
																</p>
															</cfcase>
														</cfswitch>
													</dd>
												</div>
											</dl>

										</cfloop>

										<p>
											<a href="/index.cfm?event=playground.features.detail.rule&featureKey=#encodeForUrl( feature.key )#&environmentKey=#encodeForUrl( environment.key )#">Add rule</a>
										</p>
									</dd>
								</div>
							</dl>

						</div>
					</div>

				</cfloop>

				<p>
					<a href="/index.cfm?event=playground.features.detail.delete&featureKey=#encodeForUrl( feature.key )#">Delete</a> this feature flag.
				</p>

			</section>
			<aside m-a0f59c class="panels__aside">

				<div m-a0f59c class="state">
					<cfloop array="#environments#" index="environment">
						<a href="/index.cfm?event=playground.staging.matrix###encodeForUrl( feature.key )#" m-a0f59c class="state__header">#encodeForHtml( environment.name )#</a>
					</cfloop>
					<cfloop array="#users#" index="user">
						<cfloop array="#environments#" index="environment">

							<cfset result = results[ user.id ][ environment.key ] />

							<a
								href="/index.cfm?event=playground.staging.explain&userID=#encodeForUrl( user.id )#&featureKey=#encodeForUrl( feature.key )#&environmentKey=#encodeForUrl( environment.key )#&from=targeting"
								@mouseenter="flashDistal( '#encodeForJavaScript( environment.key )#', '#result.ruleIndex#' )"
								@mouseleave="unflash()"
								data-flash-environment="#encodeForHtmlAttribute( environment.key )#"
								data-flash-rule="#encodeForHtmlAttribute( result.ruleIndex )#"
								m-a0f59c
								class="state__variant ui-variant-#result.variantIndex# flasher-distal">
							</a>
						</cfloop>
					</cfloop>
				</div>

			</aside>
		</div>

	</cfoutput>
</cfsavecontent>
