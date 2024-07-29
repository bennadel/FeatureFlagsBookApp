<cfsavecontent variable="request.template.primaryContent">
	<style type="text/css">

		dl {
			margin: 20px 0px ;
		}

		dl > div {
			margin: 10px 0 10px 0 ;
		}
		dt {
			margin: 10px 0 10px 0 ;
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
			padding: 5px 15px ;
		}
		.tile__remove {
			background-color: #f55dff ;
			border: none ;
			cursor: pointer ;
			margin: 0 ;
			padding-inline: 12px ;
		}

		.choggle {
			align-items: center ;
			display: flex ;
			gap: 10px ;
		}
		.choggle__control {}
		.choggle__label {}

	</style>
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			&larr; <a href="/index.cfm?event=features.targeting&featureKey=#encodeForUrl( feature.key )###environment-#encodeForUrl( targeting.key )#">Back to Targeting</a>
		</p>

		<dl>
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
		</dl>

		<cfif errorMessage.len()>
			<p class="error-message">
				#encodeForHtml( errorMessage )#
			</p>
		</cfif>

		<form x-data="FormController" @submit="handleSubmit()" method="post">
			<input type="hidden" name="event" value="#encodeForHtmlAttribute( request.context.event )#" />
			<input type="hidden" name="featureKey" value="#encodeForHtmlAttribute( request.context.featureKey )#" />
			<input type="hidden" name="environmentKey" value="#encodeForHtmlAttribute( request.context.environmentKey )#" />
			<input type="hidden" name="ruleIndex" value="#encodeForHtmlAttribute( request.context.ruleIndex )#" />
			<input type="hidden" name="ruleData" value="#encodeForHtmlAttribute( form.ruleData )#" x-ref="ruleData" />
			<input type="hidden" name="submitted" value="true" />

			<dl>
				<div>
					<dt>
						<strong>Input:</strong>
					</dt>
					<dd>
						<select x-model="form.input" @change="handleInput()">
							<template x-for="input in inputs">
								<option
									:value="input"
									:selected="( input === form.input )"
									x-text="input">
								</option>
							</template>
						</select>
					</dd>
				</div>
				<div>
					<dt>
						<strong>Operator:</strong>
					</dt>
					<dd>
						<select x-model="form.operator" @change="handleOperator()">
							<template x-for="operator in operators">
								<option
									:value="operator"
									:selected="( operator === form.operator )"
									x-text="operator">
								</option>
							</template>
						</select>
					</dd>
				</div>
				<div>
					<dt>
						<strong>Values:</strong>
					</dt>
					<dd>
						<div class="tiles">
							<template x-for="( value, i ) in form.values" :key="i">

								<span class="tiles__tile tile">
									<span class="tile__value" x-text="value"></span>
									<button type="button" @click="removeValue( i )" class="tile__remove">
										x
									</button>
								</span>

							</template>
							<div class="tiles__form">
								<input
									type="text"
									x-ref="valueRawRef"
									x-model.trim="form.valueRaw"
									list="value-list"
									@keydown.enter.prevent="handleValue()"
								/>
								<datalist id="value-list">
									<template x-for="option in datalist">
										<option x-text="option"></option>
									</template>
								</datalist>

								<button type="button" @click="handleValue()">
									Add
								</button>
							</div>
						</div>
					</dd>
				</div>
				<div>
					<dt>
						<strong>Resolution:</strong>
					</dt>
					<dd>
						<p>
							<strong>Use Type:</strong>

							<button type="button" @click="switchToSelection()">
								Selection
							</button>
							<button type="button" @click="switchToDistribution()">
								Distribution
							</button>
							<button type="button" @click="switchToVariant()">
								Variant
							</button>
						</p>


						<!-- Selection. -->
						<template x-if="( form.resolution.type === 'selection' )">
							<dl>
								<div>
									<dt>
										<strong>Selection:</strong>
									</dt>
									<dd>
										<template x-for="( variant, i ) in feature.variants">

											<label class="choggle">
												<input
													x-model.number="form.resolution.selection"
													type="radio"
													name="selectionIndex"
													:value="( i + 1 )"
													@change="handleSelection()"
													class="choggle__control"
												/>
												<span
													class="choggle__label"
													x-text="JSON.stringify( variant )">
												</span>
											</label>

										</template>
									</dd>
								</div>
							</dl>
						</template>

						<!-- Distribution. -->
						<template x-if="( form.resolution.type === 'distribution' )">
							<dl>
								<div>
									<dt>
										<strong>Distribution:</strong>
									</dt>
									<dd>
										<template x-for="( allocation, i ) in form.resolution.distribution">

											<label class="choggle">
												<select
													x-model.number="form.resolution.distribution[ i ]"
													@change="handleDistribution()"
													class="choggle__control">

													<template x-for="n in 101">
														<option
															:value="( n - 1 )"
															:selected="( form.resolution.distribution[ i ] === ( n - 1 ) )"
															x-text="( ( n - 1 ) + '%' )"
														></option>
													</template>
												</select>
												<span
													class="choggle__label"
													x-text="JSON.stringify( feature.variants[ i ] )">
												</span>
											</label>

										</template>

										<p>
											Total: <span x-text="form.resolution.allocationTotal"></span>

											<template x-if="( form.resolution.allocationTotal !== 100 )">
												<span>
													- <mark>must total to 100</mark>.
												</span>
											</template>
										</p>
									</dd>
								</div>
							</dl>
						</template>

						<!-- Variant. -->
						<template x-if="( form.resolution.type === 'variant' )">
							<dl>
								<div>
									<dt>
										<strong>Variant:</strong>
									</dt>
									<dd>
										<input
											type="text"
											x-model="form.resolution.variantRaw"
											@input="handleVariant()"
											size="30"
										/>
										-
										must by of type <span x-text="feature.type"></span>.
									</dd>
								</div>
							</dl>
						</template>

					</dd>
				</div>
			</dl>

			<p>
				<button type="submit">
					Save
				</button>
				<a href="/index.cfm?event=features.targeting&featureKey=#encodeForUrl( feature.key )###environment-#encodeForUrl( targeting.key )#">
					Cancel
				</a>
			</p>

		</form>

	</cfoutput>
	<script type="text/javascript">

		function FormController() {

			var feature = JSON.parse( "<cfoutput>#encodeForJavaScript( serializeJson( feature ) )#</cfoutput>" );
			var rule = JSON.parse( "<cfoutput>#encodeForJavaScript( serializeJson( rule ) )#</cfoutput>" );
			var ruleDataRef = this.$refs.ruleData;
			var datalists = JSON.parse( "<cfoutput>#encodeForJavaScript( serializeJson( datalists ) )#</cfoutput>" );

			// Return public API for proxy.
			return {
				init: $init,
				feature: feature,
				rule: rule,
				form: null,
				operators: [
					"Contains",
					"EndsWith",
					"IsOneOf",
					"MatchesPattern",
					"NotContains",
					"NotEndsWith",
					"NotIsOneOf",
					"NotMatchesPattern",
					"NotStartsWith",
					"StartsWith"
				],
				inputs: [
					"key",
					"user.id",
					"user.email",
					"user.role",
					"user.company.id",
					"user.company.subdomain",
					"user.company.fortune100",
					"user.company.fortune500",
					"user.groups.betaTester",
					"user.groups.influencer"
				],
				datalist: [],

				// Public methods.
				handleDistribution: handleDistribution,
				handleInput: handleInput,
				handleOperator: handleOperator,
				handleSelection: handleSelection,
				handleSubmit: handleSubmit,
				handleValue: handleValue,
				handleVariant: handleVariant,
				removeValue: removeValue,
				switchToDistribution: switchToDistribution,
				switchToSelection: switchToSelection,
				switchToVariant: switchToVariant,

				// Private methods.
				_persistData: persistData,
				_setAllocationTotal: setAllocationTotal,
				_setDatalist: setDatalist
			};

			// ---
			// PUBLIC METHODS.
			// ---

			function $init() {

				try {

					this.form = JSON.parse( ruleDataRef.value );

				} catch ( error ) {

					this.form = JSON.parse( JSON.stringify( rule ) );

				}

				this.form.valueRaw = "";

				if ( this.form.resolution.type !== "selection" ) {

					this.form.resolution.selection = 1;

				}

				if ( this.form.resolution.type !== "distribution" ) {

					this.form.resolution.distribution = feature.variants.map(
						( variant, i ) => {

							if ( i === 0 ) {

								return 100;

							}

							return 0;

						}
					);

				}

				if ( this.form.resolution.type !== "variant" ) {

					this.form.resolution.variant = feature.variants[ 0 ];

				}

				switch ( feature.type ) {
					case "boolean":
					case "number":
					case "string":
						this.form.resolution.variantRaw = String( this.form.resolution.variant );
					break;
					default:
						this.form.resolution.variantRaw = JSON.stringify( this.form.resolution.variant );
					break;
				}

				this._setDatalist();
				this._setAllocationTotal();

			}

			function handleDistribution() {

				this._persistData();
				this._setAllocationTotal();

			}

			function handleInput() {

				this._persistData();
				this._setDatalist();

			}

			function handleOperator() {

				this._persistData();
				this._setDatalist();

			}

			function handleSelection() {

				this._persistData();

			}

			function handleSubmit() {

				// Adding values is a bit confusing. If there's still an input value that
				// hasn't been persisted, persist it now before submitting the form.
				this.handleValue();

			}

			function handleValue() {

				if ( ! this.form.valueRaw ) {

					return;

				}

				this.form.values.push( this.form.valueRaw );
				this._persistData();

				this.form.valueRaw = "";
				this.$refs.valueRawRef.focus();

			}

			function handleVariant() {

				try {

					switch ( feature.type ) {
						case "string":
							this.form.resolution.variant = this.form.resolution.variantRaw;
						break;
						case "number":
						case "boolean":
						default:
							this.form.resolution.variant = JSON.parse( this.form.resolution.variantRaw );
						break;
					}

					this._persistData();

				} catch ( error ) {

					// console.group( "Error processing raw variant" );
					// console.log( this.form.variantRaw );
					// console.error( error );
					// console.groupEnd();

				}

			}

			function removeValue( i ) {

				this.form.values.splice( i, 1 );
				this._persistData();

			}

			function switchToDistribution() {

				if ( this.form.resolution.type === "distribution" ) {

					return;

				}

				this.form.resolution.type = "distribution";
				this._persistData();

			}

			function switchToSelection() {

				if ( this.form.resolution.type === "selection" ) {

					return;

				}

				this.form.resolution.type = "selection";
				this._persistData();

			}

			function switchToVariant() {

				if ( this.form.resolution.type === "variant" ) {

					return;

				}

				this.form.resolution.type = "variant";
				this._persistData();

			}

			// ---
			// PRIVATE METHODS.
			// ---

			function persistData() {

				ruleDataRef.value = JSON.stringify( this.form );

			}

			function setAllocationTotal() {

				this.form.resolution.allocationTotal = 0;
				this.form.resolution.distribution.forEach(
					( value ) => {

						this.form.resolution.allocationTotal += value;

					}
				);

			}

			function setDatalist() {

				// Special case for email-domain based targeting.
				if (
					( this.form.input === "user.email" ) &&
					( this.form.operator === "EndsWith" )
					) {

					this.datalist = datalists[ "user.emailDomain" ];

				} else {

					this.datalist = datalists[ this.form.input ];

				}

			}

		}

	</script>
</cfsavecontent>
