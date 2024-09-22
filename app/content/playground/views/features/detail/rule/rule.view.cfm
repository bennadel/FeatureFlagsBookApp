<cfsavecontent variable="request.template.primaryContent">
	<style type="text/css">

		.hidden {
			display: none ;
		}

		.tiles {
			display: flex ;
			flex-wrap: wrap ;
			gap: 10px ;
		}
		.tiles__tile {}

		.tile {
			background-color: #fde6ff ;
			border: 1px solid #f55dff ;
			border-radius: 3px ;
			display: flex ;
		}
		.tile__value {
			align-self: center ;
			padding: 5px 15px ;
		}
		.tile__remove {
			background-color: #f55dff ;
			border: none ;
			cursor: pointer ;
			margin: 0 ;
			padding-inline: 12px ;
		}

	</style>
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
				<input type="hidden" name="ruleIndex" value="#encodeForHtmlAttribute( ruleIndex )#" />
				<input type="hidden" name="submitted" value="true" />

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
							<div class="tiles">
								<template x-for="( value, i ) in values" :key="i">

									<span class="tiles__tile tile">
										<input type="hidden" name="values[]" :value="value" />
										<span class="tile__value" x-text="value"></span>
										<button type="button" @click="removeValue( i )" class="tile__remove">
											x
										</button>
									</span>

								</template>
								<div class="tiles__form">
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
					<div :class="{ hidden: ( resolutionType !== 'selection' ) }">
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
					<div :class="{ hidden: ( resolutionType !== 'distribution' ) }">
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
											<span class="choggle__label">
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
					<div :class="{ hidden: ( resolutionType !== 'variant' ) }">
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
			var values = JSON.parse( "<cfoutput>#encodeForJavaScript( serializeJson( form.values ) )#</cfoutput>" );

			// Return public API for proxy.
			return {
				init: $init,
				values: values,
				datalist: "",

				// Public methods.
				handleAllocation: handleAllocation,
				handleInput: handleInput,
				handleOperator: handleOperator,
				handleType: handleType,
				handleValue: handleValue,
				removeValue: removeValue,

				// Private methods.
				_setDatalist: setDatalist
			};

			// ---
			// PUBLIC METHODS.
			// ---

			/**
			* I initialize the Alpine component.
			*/
			function $init() {

				this.handleInput()
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
			* I update the datalist in response to the input change.
			*/
			function handleInput() {

				this._setDatalist();

			}

			/**
			* I update the datalist in response to the operator change.
			*/
			function handleOperator() {

				this._setDatalist();

			}

			/**
			* I update the resolution details after the type is changed.
			*/
			function handleType( event ) {

				this.resolutionType = form.elements.resolutionType.value;

			}

			/**
			* I add a new value to the 
			*/
			function handleValue() {

				if ( ! this.$refs.rawValueRef.value ) {

					return;

				}

				this.values.push( this.$refs.rawValueRef.value );
				this.$refs.rawValueRef.value = "";
				this.$refs.rawValueRef.focus();

			}

			function removeValue( i ) {

				this.values.splice( i, 1 );

			}

			// ---
			// PRIVATE METHODS.
			// ---

			function setDatalist() {

				var input = form.elements.input.value;
				var operator = form.elements.operator.value;

				// Special case for email-domain based targeting.
				if (
					( input === "user.email" ) &&
					( operator === "EndsWith" )
					) {

					this.datalist = "datalist.user.emailDomain";

				} else {

					this.datalist = `datalist.${ input }`;

				}

			}

		}

	</script>
</cfsavecontent>
