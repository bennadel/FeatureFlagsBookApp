<cfoutput>

	<article x-data="FeatureJson" class="m8-json">

		<hr class="ui-rule m8-json__rule" />

		<p>
			<button @click="toggleJson()" class="ui-text-button">
				<span x-text="( isShowingJson ? 'Hide' : 'Show' )"></span>
				current feature configuration
			</button>
		</p>

		<template x-if="isShowingJson">
			<div class="ui-readable-width">

				<h2>
					Current Configuration
				</h2>

				<p>
					This is the "#encodeForHtml( request.featureKey )#" feature configuration that is being used to render the state on the right.&nbsp;&rarr;
				</p>

				<pre class="ui-snippet"><code x-text="json"></code></pre>

			</div>
		</template>

	</article>

	<script type="text/javascript">

		function FeatureJson() {

			var el = this.$el;
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

				if ( this.isShowingJson ) {

					setTimeout(
						() => el.scrollIntoView({
							behavior: "smooth",
							block: "start"
						}),
						200
					);

				}

			}

		}

	</script>

</cfoutput>
