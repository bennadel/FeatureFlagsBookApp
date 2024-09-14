<cfscript>

	partial = getPartial();

	request.template.title = partial.title;

	include "./user.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the main partial payload for the view.
	*/
	private struct function getPartial() {

		var user = request.user;
		var title = "Account";

		return {
			user: user,
			title: title
		};

	}

</cfscript>
