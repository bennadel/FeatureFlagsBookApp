<style type="text/css">

	.feature-json {
		opacity: 0.3 ;
	}
	.feature-json:hover {
		opacity: 1.0 ;
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

		<button @click="toggleJson()" class="toggle-json">
			<span x-text="( isShowingJson ? 'Hide' : 'Show' )"></span>
			current feature configuration
		</button>

		<template x-if="isShowingJson">
			<div>
				<p class="ui-readable-width">
					This is the "#encodeForHtml( request.featureKey )#" feature configuration that is being used to render the state on the right.
				</p>

				<pre class="ui-snippet ui-readable-width"><code x-text="json"></code></pre>
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
