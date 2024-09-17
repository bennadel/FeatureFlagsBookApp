<cfsavecontent variable="request.template.primaryContent">
	<style type="text/css">

		.pretty-print {
			background-color: #fafafa ;
			border: 1px solid #cccccc ;
			border-radius: 4px ;
			display: block ;
			margin: 2em 0 0 ;
			padding: 24px 28px ;
		}
		.pretty-print code {
			display: block ;
			font-size: 16px ;
			line-height: 1.7 ;
		}

	</style>
	<cfoutput>

		<section class="content-wrapper u-collapse-margin">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p class="ui-readable-width">
				The following is the full JSON payload behind your feature flags playground data. You can <a href="/index.cfm?event=playground.features.reset&from=raw">reset this data</a> at any time.
			</p>

			<pre class="pretty-print"><code x-data="PrettyPrint"></code></pre>

		</section>

	</cfoutput>
	<script type="text/javascript">

		function PrettyPrint() {

			var config = JSON.parse( "<cfoutput>#encodeForJavaScript( serializeJson( config ) )#</cfoutput>" );

			this.$el.textContent = JSON.stringify( config, null, 4 );

		}

	</script>
</cfsavecontent>
