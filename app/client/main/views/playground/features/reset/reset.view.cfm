<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="ui-content-wrapper">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<cfmodule
				template="/client/main/tags/errorMessage.cfm"
				message="#errorMessage#"
				class="ui-readable-width"
			/>

			<form method="post" action="/index.cfm">
				<cfmodule template="/client/main/tags/event.cfm">
				<cfmodule template="/client/main/tags/xsrf.cfm">

				<p>
					<strong>Caution:</strong> This will reset your feature flag data back to its original state.
				</p>

				<p class="ui-form-buttons ui-row">
					<span class="ui-row__item">
						<button type="submit" class="ui-button is-submit is-destructive">
							Reset My Data
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
