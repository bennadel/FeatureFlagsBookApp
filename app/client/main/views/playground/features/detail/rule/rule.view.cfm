<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="ui-content-wrapper">

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

			<form x-data="mrp1ra0.FormController( JSON.parse( '#encodeForJavaScript( serializeJson( form.values ) )#' ) )" method="post">
				<input type="hidden" name="event" value="#encodeForHtmlAttribute( request.context.event )#" />
				<input type="hidden" name="featureKey" value="#encodeForHtmlAttribute( feature.key )#" />
				<input type="hidden" name="environmentKey" value="#encodeForHtmlAttribute( environment.key )#" />
				<input type="hidden" name="ruleIndex" value="#encodeForHtmlAttribute( ruleIndex )#" />
				<cfmodule template="/client/main/views/common/tags/xsrf.cfm">

				<dl>
					<div>
						<dt>
							Input:
						</dt>
						<dd>
							<select name="input" @change="handleInput()" class="ui-select">
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
							<select name="operator" @change="handleOperator()" class="ui-select">
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
							<div m-rp1ra0 class="ui-row tile-form">
								<div class="ui-row__item">
									<input
										type="text"
										name="values[]"
										x-ref="rawValueRef"
										:list="datalist"
										@keydown.enter.prevent="handleValue()"
										class="ui-input"
									/>
								</div>
								<div class="ui-row__item">
									<button type="button" @click="handleValue()" class="ui-button">
										Add
									</button>
								</div>
							</div>

							<div m-rp1ra0 class="tiles">
								<template x-if="! values.length">
									<p class="u-no-margin-y">
										<em>No values defined &mdash; use the form above to add at least one value.</em>
									</p>
								</template>
								<template x-for="( value, i ) in values" :key="i">

									<span m-rp1ra0 class="tiles__tile tile">
										<input type="hidden" name="values[]" :value="value" />
										<span m-rp1ra0 class="tile__value" x-text="value"></span>
										<button type="button" @click="removeValue( i )" m-rp1ra0 class="tile__remove">
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
						<dd class="u-breathing-room">
							<label class="ui-row">
								<span class="ui-row__item">
									<input
										type="radio"
										name="resolutionType"
										value="selection"
										#ui.attrChecked( form.resolutionType == "selection" )#
										@change="handleType()"
										class="ui-radio"
									/>
								</span>
								<span class="ui-row__item">
									Selection
								</span>
							</label>
							<label class="ui-row">
								<span class="ui-row__item">
									<input
										type="radio"
										name="resolutionType"
										value="distribution"
										#ui.attrChecked( form.resolutionType == "distribution" )#
										@change="handleType()"
										class="ui-radio"
									/>
								</span>
								<span class="ui-row__item">
									Distribution
								</span>
							</label>
							<label class="ui-row">
								<span class="ui-row__item">
									<input
										type="radio"
										name="resolutionType"
										value="variant"
										#ui.attrChecked( form.resolutionType == "variant" )#
										@change="handleType()"
										class="ui-radio"
									/>
								</span>
								<span class="ui-row__item">
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
										<label class="ui-row">
											<span class="ui-row__item">
												<input
													type="radio"
													name="resolutionSelection"
													value="#encodeForHtmlAttribute( entry.index )#"
													#ui.attrChecked( form.resolutionSelection == entry.index )#
													class="ui-radio"
												/>
											</span>
											<span class="ui-row__item">
												<span class="ui-tag ui-variant-#entry.index#">
													#encodeForHtml( serializeJson( entry.value ) )#
												</span>
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
										<label class="ui-row">
											<span class="ui-row__item">
												<select name="resolutionDistribution[]" @change="handleAllocation()" class="ui-select">
													<cfloop from="0" to="100" index="i">
														<option
															value="#i#"
															#ui.attrSelected( form.resolutionDistribution[ entry.index ] == i )#>
															#i#
														</option>
													</cfloop>
												</select>
											</span>
											<span class="ui-row__item">
												&rarr;
											</span>
											<span class="ui-row__item">
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
								maxlength="255"
								class="ui-input"
							/>

							<p>
								Note: the variant must be of type #encodeForHtml( feature.type )#.
							</p>
						</dd>
					</div>
					<!--- End: Variant. --->
				</dl>

				<p class="ui-form-buttons ui-row">
					<span class="ui-row__item">
						<button type="submit" class="ui-button is-submit">
							Save
						</button>
					</span>
					<span class="ui-row__item">
						<a href="/index.cfm?event=playground.features.detail.targeting&featureKey=#encodeForUrl( feature.key )###environment-#encodeForUrl( environment.key )#" class="ui-button is-cancel">
							Cancel
						</a>
					</span>
				</p>

			</form>

		</section>

	</cfoutput>
</cfsavecontent>
