<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="content-wrapper">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<cfif errorMessage.len()>
				<p class="ui-error-message">
					#encodeForHtml( errorMessage )#
				</p>
			</cfif>

			<form method="post">
				<input type="hidden" name="event" value="#encodeForHtmlAttribute( request.context.event )#" />
				<input type="hidden" name="submitted" value="true" />
				<input type="hidden" name="x-xsrf-token" value="#encodeForHtmlAttribute( request.xsrfToken  )#" />

				<p>
					<strong>Caution:</strong> This will reset your feature flag data back to its original state.
				</p>

				<p>
					<button type="submit">
						Reset my data
					</button>
					<a href="/index.cfm">
						Cancel
					</a>
				</p>

			</form>

		</section>

	</cfoutput>
</cfsavecontent>
