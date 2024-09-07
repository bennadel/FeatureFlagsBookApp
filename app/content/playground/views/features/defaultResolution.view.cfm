<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			&larr; <a href="/index.cfm?event=playground.features.targeting&featureKey=#encodeForUrl( feature.key )###environment-#encodeForUrl( targeting.key )#">Back to Targeting</a>
		</p>

		<dl class="key-values key-values--static">
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

		<form x-data="FormController" method="post">
			<input type="hidden" name="event" value="#encodeForHtmlAttribute( request.context.event )#" />
			<input type="hidden" name="featureKey" value="#encodeForHtmlAttribute( request.context.featureKey )#" />
			<input type="hidden" name="environmentKey" value="#encodeForHtmlAttribute( request.context.environmentKey )#" />
			<input type="hidden" name="resolutionData" value="#encodeForHtmlAttribute( form.resolutionData )#" x-ref="resolutionData" />
			<input type="hidden" name="submitted" value="true" />

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
			<template x-if="( form.type === 'selection' )">
				<dl class="key-values">
					<div>
						<dt>
							<strong>Selection:</strong>
						</dt>
						<dd>
							<ul class="no-marker breathing-room">
								<template x-for="( variant, i ) in feature.variants">

									<li>
										<label class="choggle">
											<input
												x-model.number="form.selection"
												type="radio"
												name="selectionIndex"
												:value="( i + 1 )"
												@change="handleSelection()"
												class="choggle__control"
											/>
											<span
												class="choggle__label tag" :class="( 'variant-' + ( i + 1 ) )"
												x-text="JSON.stringify( variant )">
											</span>
										</label>
									</li>

								</template>
							</ul>
						</dd>
					</div>
				</dl>
			</template>

			<!-- Distribution. -->
			<template x-if="( form.type === 'distribution' )">
				<dl class="key-values">
					<div>
						<dt>
							<strong>Distribution:</strong>
						</dt>
						<dd>
							<ul class="no-marker breathing-room">
								<template x-for="( allocation, i ) in form.distribution">

									<li>
										<label class="choggle">
											<select
												x-model.number="form.distribution[ i ]"
												@change="handleDistribution()"
												class="choggle__control">

												<template x-for="n in 101">
													<option
														:value="( n - 1 )"
														:selected="( form.distribution[ i ] === ( n - 1 ) )"
														x-text="( ( n - 1 ) + '%' )"
													></option>
												</template>
											</select>
											<span class="choggle__label">
												&rarr;
												<span
													class="tag"
													:class="( 'variant-' + ( i + 1 ) )"
													x-text="JSON.stringify( feature.variants[ i ] )">
												</span>
											</span>
										</label>
									</li>

								</template>
							</ul>

							<p>
								Total: <span x-text="form.allocationTotal"></span>

								<template x-if="( form.allocationTotal !== 100 )">
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
			<template x-if="( form.type === 'variant' )">
				<dl class="key-values">
					<div>
						<dt>
							<strong>Variant:</strong>
						</dt>
						<dd>
							<input
								type="text"
								x-model="form.variantRaw"
								@input="handleVariant()"
								size="30"
							/>
							-
							must by of type <span x-text="feature.type"></span>.
						</dd>
					</div>
				</dl>
			</template>

			<p>
				<button type="submit">
					Save
				</button>
				<a href="/index.cfm?event=playground.features.targeting&featureKey=#encodeForUrl( feature.key )###environment-#encodeForUrl( targeting.key )#">
					Cancel
				</a>
			</p>

		</form>

	</cfoutput>
	<script type="text/javascript">

		function FormController() {

			var feature = JSON.parse( "<cfoutput>#encodeForJavaScript( serializeJson( feature ) )#</cfoutput>" );
			var resolution = JSON.parse( "<cfoutput>#encodeForJavaScript( serializeJson( resolution ) )#</cfoutput>" );
			var resolutionDataRef = this.$refs.resolutionData;

			// Return public API for proxy.
			return {
				init: $init,
				feature: feature,
				resolution: resolution,
				form: null,

				// Public methods.
				handleDistribution: handleDistribution,
				handleSelection: handleSelection,
				handleVariant: handleVariant,
				switchToDistribution: switchToDistribution,
				switchToSelection: switchToSelection,
				switchToVariant: switchToVariant,

				// Private methods.
				_persistData: persistData,
				_setAllocationTotal: setAllocationTotal
			};

			// ---
			// PUBLIC METHODS.
			// ---

			function $init() {

				try {

					this.form = JSON.parse( resolutionDataRef.value );

				} catch ( error ) {

					this.form = JSON.parse( JSON.stringify( resolution ) );

				}

				if ( this.form.type !== "selection" ) {

					this.form.selection = 1;

				}

				if ( this.form.type !== "distribution" ) {

					this.form.distribution = feature.variants.map(
						( variant, i ) => {

							if ( i === 0 ) {

								return 100;

							}

							return 0;

						}
					);

				}

				if ( this.form.type !== "variant" ) {

					this.form.variant = feature.variants[ 0 ];

				}

				switch ( feature.type ) {
					case "boolean":
					case "number":
					case "string":
						this.form.variantRaw = String( this.form.variant );
					break;
					default:
						this.form.variantRaw = JSON.stringify( this.form.variant );
					break;
				}

				this._setAllocationTotal();

			}


			function handleDistribution() {

				this._persistData();
				this._setAllocationTotal();

			}

			function handleSelection() {

				this._persistData();

			}


			function handleVariant() {

				try {

					switch ( feature.type ) {
						case "string":
							this.form.variant = this.form.variantRaw;
						break;
						case "number":
						case "boolean":
						default:
							this.form.variant = JSON.parse( this.form.variantRaw );
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

			function switchToDistribution() {

				if ( this.form.type === "distribution" ) {

					return;

				}

				this.form.type = "distribution";
				this._persistData();

			}


			function switchToSelection() {

				if ( this.form.type === "selection" ) {

					return;

				}

				this.form.type = "selection";
				this._persistData();

			}


			function switchToVariant() {

				if ( this.form.type === "variant" ) {

					return;

				}

				this.form.type = "variant";
				this._persistData();

			}

			// ---
			// PRIVATE METHODS.
			// ---

			function persistData() {

				resolutionDataRef.value = JSON.stringify( this.form );

			}

			function setAllocationTotal() {

				this.form.allocationTotal = 0;
				this.form.distribution.forEach(
					( value ) => {

						this.form.allocationTotal += value;

					}
				);

			}

		}

	</script>
</cfsavecontent>
