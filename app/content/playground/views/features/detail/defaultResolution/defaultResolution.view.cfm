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

			<form x-data="FormController" method="post">
				<input type="hidden" name="event" value="#encodeForHtmlAttribute( request.context.event )#" />
				<input type="hidden" name="featureKey" value="#encodeForHtmlAttribute( feature.key )#" />
				<input type="hidden" name="environmentKey" value="#encodeForHtmlAttribute( environment.key )#" />
				<input type="hidden" name="submitted" value="true" />

				<dl>
					<div>
						<dt>
							Type:
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
											<span class="choggle__label ui-tag u-variant-#entry.index#">
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
												<span class="ui-tag u-variant-#entry.index#">
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
	<script type="text/javascript">

		function FormController() {

			var form = this.$el;

			// Return public API for proxy.
			return {
				init: $init,
				resolutionType: "",
				allocationTotal: 100,

				handleAllocation: handleAllocation,
				handleType: handleType,
			};

			// ---
			// PUBLIC METHODS.
			// ---

			/**
			* I initialize the Alpine component.
			*/
			function $init() {

				this.handleType();
				this.handleAllocation();

			}

			/**
			* I update the allocation total after one of the distributions is changed.
			*/
			function handleAllocation() {

				this.allocationTotal = 0;

				for ( var element of form.elements[ "resolutionDistribution[]" ] ) {

					this.allocationTotal += parseInt( element.value, 10 );

				}

			}

			/**
			* I update the resolution details after the type is changed.
			*/
			function handleType( event ) {

				this.resolutionType = form.elements.resolutionType.value;

			}

		}

	</script>
</cfsavecontent>
