<cfsavecontent variable="request.template.primaryContent">
	<style type="text/css">

		.panels {
			display: flex ;
			inset: 0 ;
			position: fixed ;
		}
		.panels__main {
			flex: 1 1 auto ;
			overflow: auto ;
			overscroll-behavior: contain ;
			padding: 0px 20px 20px 20px ;
		}
		.panels__aside {
			flex: 0 0 auto ;
			overflow: auto ;
			overscroll-behavior: contain ;
		}

		dl {
			margin: 20px 0px ;
		}

		dl > div {
			margin: 10px 0 10px 0 ;
		}
		dt {
			margin: 10px 0 10px 0 ;
		}

		.env {}
		.env__header {
			border-bottom: 2px solid #333333 ;
			display: flex ;
			margin: 40px 0 0 0 ;
		}
		.env__label {
			background-color: #333333 ;
			border-top-right-radius: 3px ;
			color: #ffffff ;
			padding: 10px 30px 4px 22px ;
		}
		.env__body {
			border: 2px solid #333333 ;
			padding: 20px ;
		}

		.rule {
			border: 1px dashed #999999 ;
			border-radius: 3px ;
			padding: 20px ;
		}
		.rule--disabled {
			opacity: 0.3 ;
		}

		.value-list {
			display: flex;
			flex-wrap: wrap ;
			gap: 10px ;
		}
		.value-list__item {
			border: 1px solid #f55dff ;
			border-radius: 3px ;
			padding: 2px 7px ;
		}

		.tag {
			border-radius: 3px ;
			display: inline-block ;
			padding: 2px 7px ;
		}

		.state {
			border-collapse: collapse ;
			border-spacing: 0 ;
			height: 100% ;
		}
		.state th {
			height: 40px ;
			padding: 5px 15px ;
		}
		.state td {}

		.evaluation {
			font-size: 0px ;
			line-height: 0px ;
			position: relative ;
		}
		.evaluation__link {
			inset: 0 ;
			position: absolute ;
		}
		.evaluation__link:hover {
			outline: 1px solid #ffffff ;
			outline-offset: -1px ;
		}

		.editable {
			display: flex ;
		}
		.editable:has(.editable__link:hover) {
			background-color: #f0f0f0 ;
		}
		.editable__link {
			margin-left: auto ;
			opacity: 0.7 ;
		}
		.editable__link:hover {
			opacity: 1.0 ;
		}

	</style>
	<cfoutput>

		<div class="panels">
			<main class="panels__main">

				<h1>
					#encodeForHtml( request.template.title )#
				</h1>

				<p>
					&larr; <a href="/index.cfm">Back to Overview</a>
				</p>

				<dl>
					<div>
						<dt>
							<strong>Key:</strong>
						</dt>
						<dd class="block-collapse">
							<p>
								#encodeForHtml( feature.key )#
							</p>
						</dd>
					</div>
					<div>
						<dt>
							<strong>Type:</strong>
						</dt>
						<dd class="block-collapse">
							<p>
								#encodeForHtml( feature.type )#
							</p>
						</dd>
					</div>
					<cfif feature.description.len()>
						<div>
							<dt>
								<strong>Description:</strong>
							</dt>
							<dd class="block-collapse">
								<p>
									#encodeForHtml( feature.description )#
								</p>
							</dd>
						</div>
					</cfif>
					<div>
						<dt>
							<strong>Variants:</strong>
						</dt>
						<dd class="block-collapse">
							<ol>
								<cfloop index="variantEntry" array="#utilities.toEntries( feature.variants )#">
									<li>
										<span class="tag variant-#variantEntry.index#">
											#encodeForHtml( serializeJson( variantEntry.value ) )#
										</span>
									</li>
								</cfloop>
							</ol>
						</dd>
					</div>
				</dl>

				<cfloop index="environment" array="#environments#">

					<cfset settings = feature.targeting[ environment.key ] />

					<div class="env">
						<h2 class="env__header">
							<span class="env__label">
								#encodeForHtml( environment.name )# Settings
							</span>
						</h2>
						<div class="env__body block-collapse">

							<dl>
								<div>
									<dt class="editable">
										<strong>Default Resolution:</strong>

										<a
											href="/index.cfm?event=features.defaultResolution&featureKey=#encodeForUrl( feature.key )#&environmentKey=#encodeForUrl( environment.key )#"
											class="editable__link">
											Edit
										</a>
									</dt>
									<dd class="block-collapse">
										<cfswitch expression="#settings.resolution.type#">
											<cfcase value="selection">
												<p>
													Selection
													&rarr;
													<span class="tag variant-#settings.resolution.selection#">
														#encodeForHtml( serializeJson( feature.variants[ settings.resolution.selection ] ) )#
													</span>
												</p>
											</cfcase>
											<cfcase value="distribution">
												<p>
													Distribution
												</p>
												<ul>
													<cfloop index="distributionEntry" array="#utilities.toEntries( settings.resolution.distribution )#">
														<li>
															#distributionEntry.value#%
															&rarr;
															<span class="tag variant-#distributionEntry.index#">
																#encodeForHtml( serializeJson( feature.variants[ distributionEntry.index ] ) )#
															</span>
														</li>
													</cfloop>
												</ul>
											</cfcase>
											<cfcase value="variant">
												<p>
													Variant
													&rarr;
													<span class="tag variant-0">
														#encodeForHtml( serializeJson( settings.resolution.variant ) )#
													</span>
												</p>
											</cfcase>
										</cfswitch>
									</dd>
								</div>
								<div>
									<dt>
										<strong>Rules Enabled:</strong>
									</dt>
									<dd class="block-collapse">
										<p>
											#yesNoFormat( settings.rulesEnabled )#
										</p>
									</dd>
								</div>
								<div>
									<dt>
										<strong>Rules:</strong>
									</dt>
									<dd class="block-collapse">
										<cfif ! settings.rules.len()>
											<p>
												<em>No rules</em>
											</p>
										</cfif>

										<cfloop index="ruleEntry" array="#utilities.toEntries( settings.rules )#">

											<cfset rule = ruleEntry.value />

											<dl class="rule block-collapse <cfif ! settings.rulesEnabled>rule--disabled</cfif>">
												<div>
													<dt>
														<strong>IF</strong>
													</dt>
													<dd class="block-collapse">
														<p>
															"#encodeForHtml( rule.input )#"
														</p>
													</dd>
												</div>
												<div>
													<dt>
														<strong>#encodeForHtml( rule.operator )#</strong>
													</dt>
													<dd class="block-collapse">
														<p class="value-list">
															<cfloop index="value" array="#rule.values#">
																<span class="value-list__item">
																	#encodeForHtml( serializeJson( value ) )#
																</span>
															</cfloop>
														</p>
													</dd>
												</div>
												<div>
													<dt>
														<strong>Serve:</strong>
													</dt>
													<dd class="block-collapse">
														<cfswitch expression="#rule.resolution.type#">
															<cfcase value="selection">
																<p>
																	Selection &rarr;
																	<span class="tag variant-#rule.resolution.selection#">
																		#encodeForHtml( serializeJson( feature.variants[ rule.resolution.selection ] ) )#
																	</span>
																</p>
															</cfcase>
															<cfcase value="distribution">
																<p>
																	Distribution
																</p>
																<ul>
																	<cfloop index="distributionEntry" array="#utilities.toEntries( rule.resolution.distribution )#">
																		<li>
																			#distributionEntry.value#%
																			&rarr;
																			#encodeForHtml( serializeJson( feature.variants[ distributionEntry.index ] ) )#
																		</li>
																	</cfloop>
																</ul>
															</cfcase>
															<cfcase value="variant">
																<p>
																	Variant &rarr;
																	<span class="tag variant-0">
																		#encodeForHtml( serializeJson( rule.resolution.variant ) )#
																	</span>
																</p>
															</cfcase>
														</cfswitch>
													</dd>
												</div>
											</dl>

										</cfloop>
									</dd>
								</div>
							</dl>

						</div>
					</div>

				</cfloop>

			</main>
			<aside class="panels__aside">

				<table class="state">
				<thead>
					<tr>
						<cfloop index="environment" array="#environments#">
							<th>
								<a href="/index.cfm?event=staging.overview&environmentKey=#encodeForHtml( environment.key )#">#encodeForHtml( environment.name )#</a>
							</th>
						</cfloop>
					</tr>
				</thead>
				<tbody>
					<cfloop array="#demoUsers.getUsers()#" index="demoUser">
						<tr>
							<cfloop index="environment" array="#environments#">

								<cfset result = featureFlags.debugEvaluation(
									featureKey = feature.key,
									environmentKey = environment.key,
									context = demoTargeting.getContext( demoUser ),
									fallbackVariant = "FALLBACK"
								) />

								<td class="variant-#result.variantIndex# evaluation">
									<a
										href="/index.cfm?event=staging.explain&userID=#encodeForUrl( demoUser.id )#&featureKey=#encodeForUrl( feature.key )#&environmentKey=#encodeForUrl( environment.key )#&from=targeting"
										class="evaluation__link">
									</a>
								</td>
							</cfloop>
						</tr>
					</cfloop>
				</tbody>
				</table>

			</aside>
		</div>

	</cfoutput>
</cfsavecontent>