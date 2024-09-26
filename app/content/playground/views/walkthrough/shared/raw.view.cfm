<cfoutput>

	<article x-data="m7a3b63.FeatureJson" m-7a3b63 class="m-7a3b63">

		<hr m-7a3b63 class="ui-rule" />

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

				<pre class="ui-snippet"><code x-data="m7a3b63.PrettyPrint">#encodeForHtml( serializeJson( request.feature ) )#</code></pre>

			</div>
		</template>

	</article>

</cfoutput>
