<cfsavecontent variable="request.template.primaryContent">
	<style type="text/css">

	</style>
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			<strong>Key:</strong>
			#encodeForHtml( request.context.featureKey )#
		</p>

		<cfif feature.description.len()>
			<p>
				#encodeForHtml( feature.description )#
			</p>
		</cfif>

		<cfif errorMessage.len()>
			<p>
				<strong>Error:</strong> #encodeForHtml( errorMessage )#
			</p>
		</cfif>

		<form x-data="FormController" method="post" action="/index.cfm">
			<input type="hidden" name="event" value="#encodeForHtmlAttribute( request.context.event )#" />
			<input type="hidden" name="featureKey" value="#encodeForHtmlAttribute( request.context.featureKey )#" />
			<input type="hidden" name="featureData" value="#encodeForHtmlAttribute( form.featureData )#" x-ref="featureData" />
			<input type="hidden" name="submitted" value="true" />

			<p>
				Editing coming soon...
			</p>

			<p>
				<button type="submit">
					Save
				</button>

				<a href="/index.cfm">Cancel</a>
			</p>

		</form>

	</cfoutput>
	<script type="text/javascript">

		function FormController() {

			var featureDataInput = this.$refs.featureData;
			var feature = JSON.parse( featureDataInput.value );

			console.log( feature );

		}

	</script>
</cfsavecontent>
