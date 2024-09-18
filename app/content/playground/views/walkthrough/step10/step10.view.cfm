<cfsavecontent variable="request.template.primaryContent">
	<style type="text/css">

	</style>
	<cfoutput>

		<section class="content-wrapper u-collapse-margin">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p class="ui-readable-width">
				Your feaure has been running in production for some period of time with no issues. It seems that customers are happy and the coast is clear. Time to clean-up after yourself. Remove the feature-gating logic from your code and then delete the feature flag configuration.

				<a href="/index.cfm?event=playground.walkthrough.step11">delete feature flag</a>
			</p>

		</section>

	</cfoutput>
</cfsavecontent>
