<cfoutput>

	<p
		x-data="z6oi4e.ErrorMessage"
		tabindex="-1"
		role="alert"
		aria-live="assertive"
		z6oi4e
		class="error-message #attributes.class#">

		#encodeForHtml( attributes.message )#

		<!--- So that the top of the message doesn't butt-up against the viewport. --->
		<span
			aria-hidden="true"
			x-ref="scrollTarget"
			z6oi4e
			class="scroll-margin">
		</span>
	</p>

</cfoutput>
