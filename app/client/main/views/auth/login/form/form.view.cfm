<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<h1>
			Feature Flags Playground
		</h1>

		<p>
			This is a toy application to help illustrate the way in which feature flags can be configured to target various user cohorts. It is intended to be a companion piece to the <a href="https://featureflagsbook.com/" target="_blank">Feature Flags book</a> by <a href="https://www.bennadel.com/" rel="author" target="_blank">Ben Nadel</a>.
		</p>

		<p>
			You can login with your email address. Sample data will be provisioned automatically.
		</p>

		<cfif errorMessage.len()>
			<p class="ui-error-message">
				#encodeForHtml( errorMessage )#
			</p>
		</cfif>

		<form x-data="m2wod20.FormController" method="post">
			<cfmodule template="/client/main/tags/event.cfm">
			<cfmodule template="/client/main/tags/xsrf.cfm">
			<input type="hidden" name="redirectTo" value="#encodeForHtmlAttribute( request.context.redirectTo )#" />

			<p>
				<strong>Login with email:</strong>
			</p>

			<p class="ui-row">
				<span class="ui-row__item">
					<input
						type="text"
						name="email"
						value=""
						placeholder="Email address..."
						size="30"
						maxlength="75"
						class="ui-input"
					/>
				</span>
				<span class="ui-row__item">
					<button type="submit" class="ui-button is-submit">
						Login
					</button>
				</span>
			</p>

			<p>
				<strong>Note:</strong> I only <mark>use your email address to generate the demo data</mark> for your experience. I will never email you or give away your data.
			</p>

			<!--- Turnstile CAPTCHA challenge. --->
			<div
				data-sitekey="#encodeForHtmlAttribute( config.turnstile.client.apiKey )#"
				m-2wod20
				class="cf-turnstile">
				<!---
					NOTE: This div must be inside the FORM as it will inject a hidden form
					field as a child element (which must be submitted to the server).
				--->
			</div>
		</form>

		<script src="https://challenges.cloudflare.com/turnstile/v0/api.js" async defer></script>

	</cfoutput>
</cfsavecontent>
