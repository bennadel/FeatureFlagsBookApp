<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p class="ui-readable-width">
			Let's build a feature together...
		</p>

		<dl class="key-values ui-readable-width">
			<div>
				<dt>
					<strong>Feature:</strong>
				</dt>
				<dd>
					<mark>#encodeForHtml( request.walkthroughFeature.key )#</mark>
				</dd>
			</div>
			<div>
				<dt>
					<strong>Type:</strong>
				</dt>
				<dd>
					#encodeForHtml( request.walkthroughFeature.settings.type )#
				</dd>
			</div>
			<div>
				<dt>
					<strong>Description:</strong>
				</dt>
				<dd>
					#encodeForHtml( request.walkthroughFeature.settings.description )#
				</dd>
			</div>
			<div>
				<dt>
					<strong>Variants:</strong>
				</dt>
				<dd>
					<ul class="breathing-room">
						<cfloop array="#utilities.toEntries( request.walkthroughFeature.settings.variants )#" index="entry">
							<li>
								<span class="tag variant variant-#entry.index#">
									#encodeForHtml( serializeJson( entry.value ) )#
								</span>
							</li>
						</cfloop>
					</ul>
				</dd>
			</div>
		</dl>

		<form method="get">
			<input type="hidden" name="event" value="playground.walkthrough.step2" />
			<button type="submit">
				Create Feature Flag
			</button>
		</form>

	</cfoutput>
</cfsavecontent>
