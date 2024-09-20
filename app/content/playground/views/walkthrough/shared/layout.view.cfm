<cfsavecontent variable="request.template.primaryContent">
	<style type="text/css">

		.walkthrough-panels {
			display: flex ;
			min-height: 100vh ;
		}
		.walkthrough-panels__main {
			flex: 1 1 auto ;
		}
		.walkthrough-panels__aside {
			box-shadow: -1px 0 #d0d0d0 ;
			flex: 0 0 auto ;
		}

		aside.content-wrapper {
			position: sticky ;
			top: 0 ;
		}

	</style>
	<cfoutput>

		<div class="walkthrough-panels">
			<div class="walkthrough-panels__main">

				<section class="content-wrapper u-collapse-margin">
					#request.template.primaryContent#
				</section>

			</div>
			<div class="walkthrough-panels__aside">

				<cfif request.template.asideContent.len()>

					<aside class="content-wrapper">
						#request.template.asideContent#
					</aside>

				</cfif>

			</div>
		</div>

	</cfoutput>
</cfsavecontent>
