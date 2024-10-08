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
				<cfmodule template="/client/main/views/common/tags/xsrf.cfm">

				<p>
					<strong>Caution:</strong> This will reset your feature flag data back to its original state.
				</p>

				<p class="ui-form-buttons ui-row">
					<span class="ui-row__item">
						<button type="submit" class="ui-button is-submit is-destructive">
							Reset my data
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
