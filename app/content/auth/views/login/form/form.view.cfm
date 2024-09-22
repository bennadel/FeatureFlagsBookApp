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
			<p class="ui-rror-message">
				#encodeForHtml( errorMessage )#
			</p>
		</cfif>

		<form method="post" class="u-no-margin-bottom">
			<input type="hidden" name="event" value="#encodeForHtmlAttribute( request.context.event )#" />
			<input type="hidden" name="redirectTo" value="#encodeForHtmlAttribute( request.context.redirectTo )#" />
			<input type="hidden" name="submitted" value="true" />

			<p>
				<strong>Email:</strong><br />
				<input
					type="text"
					name="email"
					value=""
					placeholder="Email address..."
					size="30"
					maxlength="75"
				/>
				<button type="submit">
					Login
				</button>
			</p>

			<!--- Turnstile CAPTCHA challenge. --->
			<div
				data-sitekey="#encodeForHtmlAttribute( config.turnstile.client.apiKey )#"
				class="cf-turnstile"
				style="margin-top: 30px ;">
				<!---
					NOTE: This div must be inside the FORM as it will inject a hidden form
					field as a child element (which must be submitted to the server).
				--->
			</div>
		</form>

		<script src="https://challenges.cloudflare.com/turnstile/v0/api.js" async defer></script>

	</cfoutput>
	<script type="text/javascript">

		if ( window.location.hash ) {

			document.querySelector( "input[ name = 'redirectTo' ]" )
				.value += window.location.hash
			;

		}

	</script>
</cfsavecontent>
