<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			#encodeForHtml( title )#
		</h1>

		<p>
			Your logout request will be processed automatically. If it is not, please use the logout button below.
		</p>

		<cfmodule
			template="/client/main/tags/errorMessage.cfm"
			message="#errorMessage#"
		/>

		<form method="post" action="/index.cfm" class="logout-form">
			<cfmodule template="/client/main/tags/event.cfm">
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
