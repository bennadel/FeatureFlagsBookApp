<cfsavecontent variable="request.template.primaryContent">
	<style type="text/css">

		html,
		body {
			margin: 0 ;
			padding: 0 ;
		}

		.panels {
			display: flex ;
			flex-direction: column ;
			inset: 0 ;
			position: fixed ;
		}
		.panels__top {
			align-items: center ;
			border-bottom: 4px solid #cccccc ;
			display: flex ;
			flex: 0 0 auto ;
			justify-content: space-between ;
			padding: 20px ;
		}
		.panels__middle {
			border-bottom: 4px solid #cccccc ;
			flex: 0 0 auto ;
		}
		.panels__bottom {
			flex: 1 1 auto ;
			position: relative ;
		}

		.title {
			margin: 0 ;
		}

		.error-message {
			background: red ;
			color: white ;
			padding: 20px ;
		}

		.editor {
			border-width: 0 ;
			font-family: monospace ;
			font-size: 20px ;
			inset: 0 ;
			line-height: 1.5 ;
			margin: 0 ;
			overscroll-behavior: contain ;
			padding: 20px ;
			position: absolute ;
		}

	</style>
	<cfoutput>

		<form method="post" action="/index.cfm" class="panels">

			<input type="hidden" name="event" value="#encodeForHtmlAttribute( request.context.event )#" />
			<input type="hidden" name="submitted" value="true" />

			<header class="panels__top">
				<h1 class="title">
					#encodeForHtml( request.template.title )#
				</h1>
				<div class="buttons">
					<button type="submit" class="buttons__control">
						Update
					</button>
					<a href="/index.cfm" class="buttons__control">
						Cancel
					</a>
				</div>
			</header>

			<cfif errorMessage.len()>
				<div class="panels__middle error-message">
					#encodeForHtml( errorMessage )#
				</div>
			</cfif>

			<div class="panels__bottom">
				<textarea name="data" class="editor">#encodeForHtml( form.data )#</textarea>
			</div>
		</form>

	</cfoutput>
	<script type="text/javascript">

		// On load, reformat the textarea value as pretty-printed JSON.
		try {

			var editor = document.querySelector( ".editor" );
			editor.value = JSON.stringify( JSON.parse( editor.value ), null, 4 );

		} catch ( error ) {

			console.error( error );

		}

	</script>
</cfsavecontent>
