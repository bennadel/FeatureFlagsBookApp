<cfscript>

	param name="attributes.message" type="string";
	param name="attributes.class" type="string" default="";

	if ( ! attributes.message.len() ) {

		exit "exitTag";

	}

	include "./errorMessage.view.cfm";

	// For CFML hierarchy purposes, allow for closing tag, but don't execute a second time.
	exit "exitTag";

</cfscript>