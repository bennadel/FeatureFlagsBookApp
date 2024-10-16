<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p>
			Your logout request will be processed automatically. If it is not, please use the logout button below.
		</p>

		<cfif errorMessage.len()>
			<p class="ui-error-message">
				#encodeForHtml( errorMessage )#
			</p>
		</cfif>

		<form method="post" action="/index.cfm" class="logout-form">
			<input type="hidden" name="event" value="#encodeForHtmlAttribute( request.context.event )#" />
			<cfmodule template="/client/main/tags/xsrf.cfm">

			<p class="ui-form-buttons ui-row">
				<span class="ui-row__item">
					<button type="submit" class="ui-button is-submit">
						Process Logout
					</button>
				</span>
				<span class="ui-row__item">
					<a href="/index.cfm?event=playground.account" class="ui-button is-cancel">
						Cancel
					</a>
				</span>
			</p>
		</form>

		<!---
			If the logout form hasn't been submitted yet, we want to auto-submit it for
			the user. This page is only meant as an invisible interstitial page to handle
			errors that might occur during the logout process.
		--->
		<cfif ! form.submitted>
			<template x-data="m5ob9aj.AutoSubmission"></template>
		</cfif>

	</cfoutput>
</cfsavecontent>
