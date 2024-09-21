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
			min-height: 100vh ;
			padding: 15px 20px 20px 20px ;
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
			font-weight: 400 ;
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
			display: grid ;
			column-gap: 1px ;
			grid-template-columns: 1fr 1fr ;
			min-width: 400px ;
		}
		.state__header {
			font-weight: bold ;
			padding: 0 15px 10px ;
			text-align: center ;
		}
		.state__variant {
			border-bottom: 0.5px solid #ffffff ;
			min-height: 4px ;
		}
		.state__variant:hover {
			outline: 3px solid #ffffff ;
			outline-offset: 0px ;
			z-index: 2 ;
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

	</style>
	<cfoutput>
		<!--- These power the mouseenter/mouseleave highlights of the evaluations. --->
		<style type="text/css">
			.flasher-distal {
				transition: opacity 300ms ease-out ;
			}

			<cfloop array="#environments#" index="environment">
				<cfloop index="i" from="0" to="20">

					.flash-root[data-flash-environment="#environment.key#"][data-flash-rule="#i#"]
						.flasher-proximal[data-flash-environment="#environment.key#"][data-flash-rule="#i#"] {
							border-radius: 1px ;
							outline: 1px dashed deeppink ;
							outline-offset: 4px ;
						}

					.flash-root[data-flash-source="distal"][data-flash-environment="#environment.key#"][data-flash-rule="#i#"]
						.flasher-proximal[data-flash-environment="#environment.key#"][data-flash-rule="#i#"] {
							animation: 500ms infinite proximal-animated ;
							outline: 2px solid deeppink ;
						}

					.flash-root[data-flash-environment="#environment.key#"][data-flash-rule="#i#"]
						.flasher-distal:not([data-flash-environment="#environment.key#"][data-flash-rule="#i#"]) {
							opacity: 0.2 ;
						}

				</cfloop>
			</cfloop>

			@keyframes proximal-animated {
				50% {
					outline-offset: 6px ;
				}
			}
		</style>
	</cfoutput>
	<cfoutput>

		<div x-data="FlashRoot" class="panels flash-root">
			<section class="panels__main content-wrapper u-collapse-margin">

				<h1>
					#encodeForHtml( title )#
				</h1>

				<dl class="key-values ui-readable-width">
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
										<span class="tag u-variant-#variantEntry.index#">
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
									@mouseenter="flashProximal( '#encodeForJavaScript( environment.key )#' )"
									@mouseleave="unflash()"
									data-flash-environment="#encodeForHtmlAttribute( environment.key )#"
									data-flash-rule="0"
									class="flasher-proximal">
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
													<span class="tag u-variant-#settings.resolution.selection#">
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
																<span class="tag u-variant-#distributionEntry.index#">
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
													<span class="tag u-variant-0">
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
												@mouseenter="flashProximal( '#encodeForJavaScript( environment.key )#', '#ruleEntry.index#', #serializeJson( ! settings.rulesEnabled )# )"
												@mouseleave="unflash()"
												data-flash-environment="#encodeForHtmlAttribute( environment.key )#"
												data-flash-rule="#encodeForHtmlAttribute( ruleEntry.index )#"
												class="key-values rule <cfif ! settings.rulesEnabled>rule--disabled</cfif> flasher-proximal">
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
																	<span class="tag u-variant-#rule.resolution.selection#">
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
																				<span class="tag u-variant-#distributionEntry.index#">
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
																	<span class="tag u-variant-0">
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

				<div class="state">
					<cfloop array="#environments#" index="environment">
						<a href="/index.cfm?event=playground.staging.matrix###encodeForUrl( feature.key )#" class="state__header">#encodeForHtml( environment.name )#</a>
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
								class="state__variant u-variant-#result.variantIndex# flasher-distal">
							</a>
						</cfloop>
					</cfloop>
				</div>

			</aside>
		</div>

	</cfoutput>
	<script type="text/javascript">

		function FlashRoot() {

			var root = this.$el;
			var unflashTimer = null;
			var scrollTimer = null;

			return {
				flashDistal: flashDistal,
				flashProximal: flashProximal,
				unflash: unflash
			};

			/**
			* I highlight the associations, sourced from the distal trigger.
			*/
			function flashDistal( environmentKey, ruleIndex ) {

				clearTimeout( unflashTimer );
				clearTimeout( scrollTimer );

				root.dataset.flashSource = "distal";
				root.dataset.flashEnvironment = environmentKey;
				root.dataset.flashRule = ruleIndex;

				scrollTimer = setTimeout(
					() => {

						root
							.querySelector( `.flasher-proximal[data-flash-environment="${ environmentKey }"][data-flash-rule="${ ruleIndex }"]` )
							.scrollIntoView({
								behavior: "smooth",
								block: "center"
							})
						;

					},
					500
				);

			}

			/**
			* I highlight the associations, sourced from the proximal trigger.
			*/
			function flashProximal( environmentKey, ruleIndex = 0, ignoreEvent = false ) {

				if ( ignoreEvent ) {

					return;

				}

				clearTimeout( unflashTimer );
				clearTimeout( scrollTimer );

				root.dataset.flashSource = "proximal";
				root.dataset.flashEnvironment = environmentKey;
				root.dataset.flashRule = ruleIndex;

			}

			/**
			* I remove the association highlight.
			*/
			function unflash() {

				clearTimeout( unflashTimer );
				clearTimeout( scrollTimer );
				unflashTimer = setTimeout(
					() => {

						delete root.dataset.flashSource;
						delete root.dataset.flashEnvironment;
						delete root.dataset.flashRule;

					},
					250
				);

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
