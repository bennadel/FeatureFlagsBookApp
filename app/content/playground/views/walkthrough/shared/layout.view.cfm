<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<div class="m6-panels">
			<div class="m6-panels__main">

				<section class="m6-panels__main-wrapper content-wrapper">
					#request.template.primaryContent#
				</section>

			</div>
			<cfif request.template.asideContent.len()>

				<div class="m6-panels__aside">
					<aside class="m6-panels__aside-wrapper content-wrapper">
						#request.template.asideContent#
					</aside>
				</div>

			</cfif>
		</div>

	</cfoutput>
</cfsavecontent>
