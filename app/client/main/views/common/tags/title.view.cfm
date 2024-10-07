<cfoutput>
	<title>
		#encodeForHtml( request.template.title )#

		<!--- Don't double-up on site title. --->
		<cfif ( request.template.title != siteName )>
			&mdash; #encodeForHtml( siteName )#
		</cfif>
	</title>
</cfoutput>
