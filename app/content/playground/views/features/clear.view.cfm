<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="content-wrapper u-collapse-margin">

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
					<strong>Caution:</strong> This will delete all rules and apply a default resolution to select the first variant.
				</p>

				<p>
					<button type="submit">
						Remove all rules
					</button>
					<a href="/index.cfm">
						Cancel
					</a>
				</p>

			</form>

		</section>

	</cfoutput>
</cfsavecontent>
