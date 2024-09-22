<style type="text/css">

	.feature-json {
		opacity: 0.2 ;
	}
	.feature-json:hover {
		opacity: 1.0 ;
		transition: opacity 300ms ease-out ;
	}

	.json-rule {
		margin: 3rem 0 1.5rem ;
	}

	.toggle-json {
		background-color: transparent ;
		border: none ;
		margin: 0 ;
		padding: 0 ;
		text-decoration: underline ;
	}

</style>
<cfoutput>

	<article x-data="FeatureJson" class="feature-json">

		<hr class="ui-rule json-rule" />

		<p>
			<button @click="toggleJson()" class="toggle-json">
				<span x-text="( isShowingJson ? 'Hide' : 'Show' )"></span>
				current feature configuration
			</button>
		</p>

		<template x-if="isShowingJson">
			<div class="ui-readable-width">

				<p>
					This is the "#encodeForHtml( request.featureKey )#" feature configuration that is being used to render the state on the right.&nbsp;&rarr;
				</p>

				<pre class="ui-snippet"><code x-text="json"></code></pre>

			</div>
		</template>

	</article>

	<script type="text/javascript">

		function FeatureJson() {

			var feature = JSON.parse( "#encodeForJavaScript( serializeJson( request.feature ) )#" );

			return {
				isShowingJson: false,
				json: "",
				toggleJson: toggleJson
			};

			function toggleJson() {

				this.isShowingJson = ! this.isShowingJson;
				this.json = ( this.isShowingJson )
					? JSON.stringify( feature, null, "\t" )
					: ""
				;

			}

		}

	</script>

</cfoutput>
