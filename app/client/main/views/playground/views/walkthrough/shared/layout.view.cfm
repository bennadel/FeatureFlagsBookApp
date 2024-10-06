<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<div m-xemm6a class="panels">
			<div m-xemm6a class="panels__main">

				<section m-xemm6a class="main-wrapper ui-content-wrapper">
					#request.template.primaryContent#
				</section>

			</div>
			<cfif request.template.asideContent.len()>

				<div m-xemm6a class="panels__aside">
					<aside m-xemm6a class="aside-wrapper ui-content-wrapper">
						#request.template.asideContent#
					</aside>
				</div>

			</cfif>
		</div>

	</cfoutput>
</cfsavecontent>
