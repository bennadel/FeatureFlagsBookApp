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
			</dl>

			<hr class="ui-rule is-soft" />

			<cfif errorMessage.len()>
				<p class="ui-error-message">
					#encodeForHtml( errorMessage )#
				</p>
			</cfif>

			<form x-data="m9dac10.FormController( JSON.parse( '#encodeForJavaScript( serializeJson( form.values ) )#' ) )" method="post">
				<input type="hidden" name="event" value="#encodeForHtmlAttribute( request.context.event )#" />
				<input type="hidden" name="featureKey" value="#encodeForHtmlAttribute( feature.key )#" />
				<input type="hidden" name="environmentKey" value="#encodeForHtmlAttribute( environment.key )#" />
				<input type="hidden" name="ruleIndex" value="#encodeForHtmlAttribute( ruleIndex )#" />
				<input type="hidden" name="submitted" value="true" />
				<input type="hidden" name="x-xsrf-token" value="#encodeForHtmlAttribute( request.xsrfToken  )#" />

				<dl>
					<div>
						<dt>
							Input:
						</dt>
						<dd>
							<select name="input" @change="handleInput()">
								<cfloop array="#inputs#" index="input">
									<option
										value="#encodeForHtmlAttribute( input )#"
										#ui.attrSelected( form.input == input )#>
										#encodeForHtml( input )#
									</option>
								</cfloop>
							</select>
						</dd>
					</div>
					<div>
						<dt>
							Operator:
						</dt>
						<dd>
							<select name="operator" @change="handleOperator()">
								<cfloop array="#operators#" index="operator">
									<option
										value="#encodeForHtmlAttribute( operator )#"
										#ui.attrSelected( form.operator == operator )#>
										#encodeForHtml( operator )#
									</option>
								</cfloop>
							</select>
						</dd>
					</div>
					<div>
						<dt>
							Values:
						</dt>
						<dd>
							<div m-9dac10 class="u-flex-row tile-form">
								<input
									type="text"
									name="values[]"
									x-ref="rawValueRef"
									:list="datalist"
									@keydown.enter.prevent="handleValue()"
								/>
								<button type="button" @click="handleValue()">
									Add
								</button>
							</div>

							<div m-9dac10 class="tiles">
								<template x-if="! values.length">
									<p class="u-no-margin-y">
										<em>No values defined &mdash; use the form above to add at least one value.</em>
									</p>
								</template>
								<template x-for="( value, i ) in values" :key="i">

									<span m-9dac10 class="tiles__tile tile">
										<input type="hidden" name="values[]" :value="value" />
										<span m-9dac10 class="tile__value" x-text="value"></span>
										<button type="button" @click="removeValue( i )" m-9dac10 class="tile__remove">
											x
										</button>
									</span>

								</template>
							</div>

							<cfloop array="#datalists#" index="entry">
								<datalist id="datalist.#entry.key#">
									<cfloop array="#entry.value#" index="option">
										<option>#encodeForHtml( option )#</option>
									</cfloop>
								</datalist>
							</cfloop>
						</dd>
					</div>
					<div>
						<dt>
							Resolution:
						</dt>
						<dd>
							<label class="choggle">
								<input
									type="radio"
									name="resolutionType"
									value="selection"
									#ui.attrChecked( form.resolutionType == "selection" )#
									@change="handleType()"
									class="choggle__control"
								/>
								<span class="choggle__label">
									Selection
								</span>
							</label>
							<label class="choggle">
								<input
									type="radio"
									name="resolutionType"
									value="distribution"
									#ui.attrChecked( form.resolutionType == "distribution" )#
									@change="handleType()"
									class="choggle__control"
								/>
								<span class="choggle__label">
									Distribution
								</span>
							</label>
							<label class="choggle">
								<input
									type="radio"
									name="resolutionType"
									value="variant"
									#ui.attrChecked( form.resolutionType == "variant" )#
									@change="handleType()"
									class="choggle__control"
								/>
								<span class="choggle__label">
									Variant
								</span>
							</label>
						</dd>
					</div>

					<!--- Start: Selection. --->
					<div :class="{ 'u-hidden': ( resolutionType !== 'selection' ) }">
						<dt>
							Selection:
						</dt>
						<dd>
							<ul class="u-no-marker u-breathing-room">
								<cfloop array="#utilities.toEntries( feature.variants )#" index="entry">

									<li>
										<label class="choggle">
											<input
												type="radio"
												name="resolutionSelection"
												value="#encodeForHtmlAttribute( entry.index )#"
												#ui.attrChecked( form.resolutionSelection == entry.index )#
												class="choggle__control"
											/>
											<span class="choggle__label ui-tag ui-variant-#entry.index#">
												#encodeForHtml( serializeJson( entry.value ) )#
											</span>
										</label>
									</li>

								</cfloop>
							</ul>
						</dd>
					</div>
					<!--- End: Selection. --->

					<!--- Start: Distribution. --->
					<div :class="{ 'u-hidden': ( resolutionType !== 'distribution' ) }">
						<dt>
							Distribution:
						</dt>
						<dd>
							<ul class="u-no-marker u-breathing-room">
								<cfloop array="#utilities.toEntries( feature.variants )#" index="entry">

									<li>
										<label class="choggle">
											<select name="resolutionDistribution[]" @change="handleAllocation()" class="choggle__control">
												<cfloop from="0" to="100" index="i">
													<option
														value="#i#"
														#ui.attrSelected( form.resolutionDistribution[ entry.index ] == i )#>
														#i#
													</option>
												</cfloop>
											</select>
											<span class="choggle__label u-flex-row">
												&rarr;
												<span class="ui-tag ui-variant-#entry.index#">
													#encodeForHtml( serializeJson( entry.value ) )#
												</span>
											</span>
										</label>
									</li>

								</cfloop>
							</ul>

							<p>
								Total: <span x-text="allocationTotal"></span>

								<template x-if="( allocationTotal !== 100 )">
									<span>
										- <mark>must total to 100</mark>.
									</span>
								</template>
							</p>
						</dd>
					</div>
					<!--- End: Distribution. --->

					<!--- Start: Variant. --->
					<div :class="{ 'u-hidden': ( resolutionType !== 'variant' ) }">
						<dt>
							Variant:
						</dt>
						<dd>
							<input
								type="text"
								name="resolutionVariant"
								value="#encodeForHtmlAttribute( form.resolutionVariant )#"
								size="30"
							/>
							-
							must by of type #encodeForHtml( feature.type )#.
						</dd>
					</div>
					<!--- End: Variant. --->
				</dl>

				<p>
					<button type="submit">
						Save
					</button>
					<a href="/index.cfm?event=playground.features.detail.targeting&featureKey=#encodeForUrl( feature.key )###environment-#encodeForUrl( environment.key )#">
						Cancel
					</a>
				</p>

			</form>

		</section>

	</cfoutput>
</cfsavecontent>
