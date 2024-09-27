<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<div m-d71598 class="panels">
			<div m-d71598 class="panels__main">

				<section m-d71598 class="main-wrapper ui-content-wrapper">
					#request.template.primaryContent#
				</section>

			</div>
			<cfif request.template.asideContent.len()>

				<div m-d71598 class="panels__aside">
					<aside m-d71598 class="aside-wrapper ui-content-wrapper">
						#request.template.asideContent#
					</aside>
				</div>

			</cfif>
		</div>

	</cfoutput>
</cfsavecontent>
