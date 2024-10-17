<cfoutput>

	<input type="hidden" name="submitted" value="true" />
	<input
		type="hidden"
		name="#encodeForHtmlAttribute( challengeName )#"
		value="#encodeForHtmlAttribute( request.xsrfToken  )#"
	/>

</cfoutput>