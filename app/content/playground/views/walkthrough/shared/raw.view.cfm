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

				<pre class="ui-snippet"><code x-data="PrettyPrint">#encodeForHtml( serializeJson( request.feature ) )#</code></pre>

			</div>
		</template>

	</article>

	<script type="text/javascript">

		function PrettyPrint() {

			this.$el.textContent = JSON.stringify(
				JSON.parse( this.$el.textContent ),
				null,
				4
			);

		}

		function FeatureJson() {

			var el = this.$el;

			return {
				isShowingJson: false,
				toggleJson: toggleJson
			};

			function toggleJson() {

				this.isShowingJson = ! this.isShowingJson;

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
