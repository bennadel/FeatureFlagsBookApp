<cfscript>

	user = request.user;
	title = "Account";

	request.template.title = title;

	include "./user.view.cfm";

</cfscript>
