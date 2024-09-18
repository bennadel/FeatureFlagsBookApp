<cfsavecontent variable="request.template.primaryContent">
	<style type="text/css">

	</style>
	<cfoutput>

		<section class="content-wrapper u-collapse-margin">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p class="ui-readable-width">
				Ok, we now have a new feature in a default state. Every user is receiving the same value. To start development, let's enable the feature locally.

				<a href="/index.cfm?event=playground.walkthrough.step3">enable in development</a>
			</p>

		</section>

	</cfoutput>
</cfsavecontent>
