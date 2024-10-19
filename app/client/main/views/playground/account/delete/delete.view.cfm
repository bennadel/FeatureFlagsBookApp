<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="ui-content-wrapper">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p class="ui-readable-width">
				This will delete your demo data and log you out of the feature flags playground. You can log back in at any time with your email address and fresh demo data will be generated.
			</p>

			<p class="ui-readable-width">
				I hope that you had fun and learned something about feature flags.
			</p>

			<cfmodule
				template="/client/main/tags/errorMessage.cfm"
				message="#errorMessage#"
				class="ui-readable-width"
			/>

			<form method="post" action="/index.cfm">
				<cfmodule template="/client/main/tags/event.cfm">
				<cfmodule template="/client/main/tags/xsrf.cfm">

				<p class="ui-form-buttons ui-row">
					<span class="ui-row__item">
						<button type="submit" class="ui-button is-submit is-destructive">
							Delete Account
						</button>
					</span>
					<span class="ui-row__item">
						<a href="/index.cfm?event=playground.account" class="ui-button is-cancel">
							Cancel
						</a>
					</span>
				</p>

			</form>

		</section>

	</cfoutput>
</cfsavecontent>
