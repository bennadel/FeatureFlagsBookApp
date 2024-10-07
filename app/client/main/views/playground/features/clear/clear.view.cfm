<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="ui-content-wrapper">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<cfif errorMessage.len()>
				<p class="ui-error-message">
					#encodeForHtml( errorMessage )#
				</p>
			</cfif>

			<form method="post" action="/index.cfm">
				<input type="hidden" name="event" value="#encodeForHtmlAttribute( request.context.event )#" />
				<input type="hidden" name="submitted" value="true" />
				<input type="hidden" name="x-xsrf-token" value="#encodeForHtmlAttribute( request.xsrfToken  )#" />

				<p>
					<strong>Caution:</strong> This will delete all rules and apply a default resolution to select the first variant.
				</p>

				<p class="ui-form-buttons ui-row">
					<span class="ui-row__item">
						<button type="submit" class="ui-button is-submit is-destructive">
							Remove all rules
						</button>
					</span>
					<span class="ui-row__item">
						<a href="/index.cfm" class="ui-button is-cancel">
							Cancel
						</a>
					</span>
				</p>

			</form>

		</section>

	</cfoutput>
</cfsavecontent>
