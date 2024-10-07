<cfoutput>

	<article x-data="mj3oyz3.FeatureJson" m-j3oyz3 class="m-j3oyz3">

		<hr m-j3oyz3 class="ui-rule" />

		<p>
			<button @click="toggleJson()" class="ui-button is-text">
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

				<pre class="ui-snippet"><code x-data="mj3oyz3.PrettyPrint">#encodeForHtml( serializeJson( request.feature ) )#</code></pre>

			</div>
		</template>

	</article>

</cfoutput>
