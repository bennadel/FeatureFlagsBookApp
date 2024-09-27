<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="ui-content-wrapper">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p class="ui-readable-width">
				The following is the full JSON payload behind your feature flags playground data. You can <a href="/index.cfm?event=playground.features.reset&from=raw">reset this data</a> at any time.
			</p>

			<pre class="ui-snippet"><code x-data="m5b9454.PrettyPrint">#encodeForHtml( serializeJson( config ) )#</code></pre>

		</section>

	</cfoutput>
</cfsavecontent>
