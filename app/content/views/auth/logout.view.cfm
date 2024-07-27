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

		<form method="post" class="logout-form">
			<input type="hidden" name="event" value="#encodeForHtmlAttribute( request.context.event )#" />
			<input type="hidden" name="submitted" value="true" />

			<p>
				<button type="submit">
					Process Logout
				</button>

				<a href="/">
					Cancel
				</a>
			</p>
		</form>

		<!---
			If the logout form hasn't been submitted yet, we want to auto-submit it for
			the user. This page is only meant as an invisible interstitial page to handle
			errors that might occur during the logout process.
		--->
		<cfif ! form.submitted>
			<script type="text/javascript">

				document.querySelector( ".logout-form" ).submit();

			</script>
		</cfif>

	</cfoutput>
</cfsavecontent>
