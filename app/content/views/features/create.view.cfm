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

		.choggle {
			align-items: center ;
			display: flex ;
			gap: 10px ;
		}
		.choggle--inline {
			display: inline-flex ;
		}
		.choggle__control {}
		.choggle__label {}

	</style>
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<cfif errorMessage.len()>
			<p class="error-message">
				#encodeForHtml( errorMessage )#
			</p>
		</cfif>

		<form method="post">
			<input type="hidden" name="event" value="#encodeForHtmlAttribute( request.context.event )#" />
			<input type="hidden" name="submitted" value="true" />

			<dl class="block-collapse">
				<div>
					<dt>
						<strong>Key:</strong>
					</dt>
					<dd>
						<input
							type="text"
							name="featureKey"
							value="#encodeForHtmlAttribute( form.featureKey )#"
							size="40"
						/>
					</dd>
				</div>
				<div>
					<dt>
						<strong>Type:</strong>
					</dt>
					<dd>
						<cfloop index="featureType" array="#[ 'boolean', 'string', 'number' ]#">

							<label class="choggle">
								<input
									type="radio"
									name="type"
									value="#encodeForHtmlAttribute( featureType )#"
									<cfif ( form.type == featureType )>
										checked
									</cfif>
									class="choggle__control"
								/>
								<span class="choggle__label">
									#encodeForHtml( featureType )#
								</span>
							</label>

						</cfloop>

						<p>
							Note: I'm omitting the "any" type in order to keep things simple.
						</p>
					</dd>
				</div>
				<div>
					<dt>
						<strong>Description:</strong>
					</dt>
					<dd>
						<textarea cols="50" rows="3">#encodeForHtml( form.description )#</textarea>
					</dd>
				</div>
				<div>
					<dt>
						<strong>Variants:</strong>
					</dt>
					<dd>
						<ol>
							<cfloop index="entry" array="#utilities.toEntries( form.variantsRaw )#">
								<li>
									<input
										type="text"
										name="variantsRaw[]"
										value="#encodeForHtmlAttribute( entry.value )#"
										size="30"
									/>
									<label class="choggle choggle--inline">
										<input
											type="radio"
											name="defaultSelection"
											value="#encodeForHtmlAttribute( entry.index )#"
											<cfif ( form.defaultSelection == entry.index )>
												checked
											</cfif>
											class="choggle__control"
										/>
										<span class="=choggle__label">
											Use as default.
										</span>
									</label>
								</li>
							</cfloop>
						</ol>
					</dd>
				</div>
			</dl>

			<p>
				<button type="submit">
					Create Feature
				</button>
				<a href="/index.cfm">
					Cancel
				</a>
			</p>

		</form>

	</cfoutput>
</cfsavecontent>
