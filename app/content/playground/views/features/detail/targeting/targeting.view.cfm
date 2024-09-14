<cfsavecontent variable="request.template.primaryContent">
	<style type="text/css">

		.panels {
			align-items: flex-start ;
			display: flex ;
		}
		.panels__main {
			flex: 1 1 auto ;
		}
		.panels__aside {
			box-shadow: -1px 0 #d0d0d0 ;
			display: flex ;
			flex: 0 0 auto ;
			max-height: 100vh ;
			min-height: 100vh ;
			padding: 20px ;
			position: sticky ;
			top: 0 ;
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
			background-color: #ffffff ;
			border-bottom: 2px solid #333333 ;
			display: flex ;
			margin: 40px 0 0 0 ;
			position: sticky ;
			top: 0px ;
			z-index: 2 ;
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
		.env__body .key-values {
			margin: 10px 0 ;
		}
		.env__body > .key-values {
			margin: 0 ;
		}

		.rule {
			border: 1px dashed #999999 ;
			border-radius: 3px ;
			padding: 20px ;
		}
		.rule:hover {
			border-style: solid ;
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

		.state {
			border-collapse: collapse ;
			border-spacing: 0 ;
			min-width: 400px ;
		}
		.state th {
			padding: 0 ;
		}
		.state th a {
			display: block ;
			padding: 0 15px 10px ;
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
			cursor: pointer ;
			display: flex ;
		}
		.editable:hover {
			background-color: #f0f0f0 ;
		}
		.editable__link {
			opacity: 0.7 ;
		}
		.editable__link:nth-of-type(1) {
			margin-left: auto ;
		}
		.editable__link:nth-of-type(2) {
			margin-left: 15px ;
		}
		.editable__link:hover {
			opacity: 1.0 ;
		}

		.flasher:hover {
			border-radius: 1px ;
			outline: 2px dashed #aaaaaa ;
			outline-offset: 4px ;
		}

	</style>
	<cfoutput>
		<!--- These power the mouseenter/mouseleave highlights of the evaluations. --->
		<style type="text/css">
			.evaluation {
				transition: background-color 300ms ease-out ;
			}

			<cfloop array="#environments#" index="environment">
				<cfloop index="i" from="0" to="20">
					.state.#environment.key#\:#i# .evaluation:not(.#environment.key#\:#i#) {
						background-color: ##ffffff ;
					}
				</cfloop>
			</cfloop>
		</style>
	</cfoutput>
	<cfoutput>

		<div class="panels">
			<section class="panels__main content-wrapper u-collapse-margin">

				<h1>
					#encodeForHtml( title )#
				</h1>

				<dl class="key-values">
					<div>
						<dt>
							<strong>Key:</strong>
						</dt>
						<dd>
							<p>
								#encodeForHtml( feature.key )#
							</p>
						</dd>
					</div>
					<div>
						<dt>
							<strong>Type:</strong>
						</dt>
						<dd>
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
							<dd>
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
						<dd>
							<ol class="breathing-room">
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

				<cfloop array="#environments#" index="environment">

					<cfset settings = feature.targeting[ environment.key ] />

					<div id="environment-#encodeForHtmlAttribute( environment.key )#" class="env">
						<h2 class="env__header">
							<span class="env__label">
								#encodeForHtml( environment.name )# Environment
							</span>
						</h2>
						<div class="env__body">

							<dl class="key-values">
								<div
									x-data="Flasher( '#encodeForJavaScript( environment.key )#' )"
									@mouseenter="handleMouseenter()"
									@mouseleave="handleMouseleave()"
									class="flasher">
									<dt x-data="Editable" @click="handleClick()" class="editable">
										<strong>Default Resolution:</strong>

										<a
											href="/index.cfm?event=playground.features.detail.defaultResolution&featureKey=#encodeForUrl( feature.key )#&environmentKey=#encodeForUrl( environment.key )#"
											x-ref="edit"
											class="editable__link">
											Edit
										</a>
									</dt>
									<dd>
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
												<ul class="breathing-room">
													<cfloop index="distributionEntry" array="#utilities.toEntries( settings.resolution.distribution )#">
														<cfif distributionEntry.value>
															<li>
																#distributionEntry.value#%
																&rarr;
																<span class="tag variant-#distributionEntry.index#">
																	#encodeForHtml( serializeJson( feature.variants[ distributionEntry.index ] ) )#
																</span>
															</li>
														</cfif>
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
									<dt x-data="Editable" @click="handleClick()" class="editable">
										<strong>Rules Enabled:</strong>

										<a
											href="/index.cfm?event=playground.features.detail.rulesEnabled&featureKey=#encodeForUrl( feature.key )#&environmentKey=#encodeForUrl( environment.key )#"
											x-ref="edit"
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
										<strong>Rules:</strong>
									</dt>
									<dd>
										<cfloop index="ruleEntry" array="#utilities.toEntries( settings.rules )#">

											<cfset rule = ruleEntry.value />

											<dl
												x-data="Flasher( '#encodeForJavaScript( environment.key )#', #ruleEntry.index#, #serializeJson( ! settings.rulesEnabled )# )"
												@mouseenter="handleMouseenter()"
												@mouseleave="handleMouseleave()"
												class="key-values rule <cfif ! settings.rulesEnabled>rule--disabled</cfif> flasher">
												<div>
													<dt x-data="Editable" @click="handleClick()" class="editable">
														<strong>IF</strong>

														<a
															href="/index.cfm?event=playground.features.detail.rule&featureKey=#encodeForUrl( feature.key )#&environmentKey=#encodeForUrl( environment.key )#&ruleIndex=#encodeForUrl( ruleEntry.index )#"
															x-ref="edit"
															class="editable__link">
															Edit
														</a>
														<a
															href="/index.cfm?event=playground.features.detail.deleteRule&featureKey=#encodeForUrl( feature.key )#&environmentKey=#encodeForUrl( environment.key )#&ruleIndex=#encodeForUrl( ruleEntry.index )#"
															class="editable__link">
															Delete
														</a>
													</dt>
													<dd>
														<p>
															"#encodeForHtml( rule.input )#"
														</p>
													</dd>
												</div>
												<div>
													<dt>
														<strong>#encodeForHtml( rule.operator )#</strong>
													</dt>
													<dd>
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
													<dd>
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
																<ul class="breathing-room">
																	<cfloop index="distributionEntry" array="#utilities.toEntries( rule.resolution.distribution )#">
																		<cfif distributionEntry.value>
																			<li>
																				#distributionEntry.value#%
																				&rarr;
																				<span class="tag variant-#distributionEntry.index#">
																					#encodeForHtml( serializeJson( feature.variants[ distributionEntry.index ] ) )#
																				</span>
																			</li>
																		</cfif>
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
			<aside class="panels__aside">

				<table class="state">
				<thead>
					<tr>
						<cfloop array="#environments#" index="environment">
							<th>
								<a href="/index.cfm?event=playground.staging.matrix&environmentKey=#encodeForHtml( environment.key )#">#encodeForHtml( environment.name )#</a>
							</th>
						</cfloop>
					</tr>
				</thead>
				<tbody>
					<cfloop array="#users#" index="user">
						<tr>
							<cfloop array="#environments#" index="environment">

								<cfset result = results[ user.id ][ environment.key ] />
								<cfset association = "#environment.key#:#result.ruleIndex#" />

								<td class="variant-#result.variantIndex# evaluation #encodeForHtmlAttribute( association )#">
									<a
										href="/index.cfm?event=playground.staging.explain&userID=#encodeForUrl( user.id )#&featureKey=#encodeForUrl( feature.key )#&environmentKey=#encodeForUrl( environment.key )#&from=targeting"
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
	<script type="text/javascript">

		function Flasher( environmentKey, ruleIndex = 0, ignoreEvent = false ) {

			var table = document.querySelector( ".state" );
			var association = `${ environmentKey }:${ ruleIndex }`;

			return {
				// Public methods.
				handleMouseenter: handleMouseenter,
				handleMouseleave: handleMouseleave
			};

			// ---
			// PUBLIC METHODS.
			// ---

			function handleMouseenter() {

				if ( ignoreEvent ) {

					return;

				}

				table.classList.add( association );

			}

			function handleMouseleave() {

				if ( ignoreEvent ) {

					return;

				}

				table.classList.remove( association );

			}

		}

		function Editable() {

			return {
				handleClick: handleClick
			};

			// ---
			// PUBLIC METHODS.
			// ---

			function handleClick() {

				if ( ! this.$refs.edit.contains( this.$event.target ) ) {

					this.$refs.edit.click();

				}

			}

		}

	</script>
</cfsavecontent>
