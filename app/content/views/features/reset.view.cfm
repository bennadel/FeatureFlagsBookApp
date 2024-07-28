<cfsavecontent variable="request.template.primaryContent">
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

	</cfoutput>
</cfsavecontent>
