<cfscript>

	param name="attributes.type" type="string";

	icons = {
		"account": "svg-sprite--legacy-streamline-regular--users--geometric-close-up-single-users-neutral--single-neutraleutral",
		"ask": "svg-sprite--messages-bubble-square-add--18397",
		"feature-flags": "svg-sprite--legacy-streamline-regular--interface-essential--lists--list-bullets-1",
		"logo": "svg-sprite--logo",
		"play": "svg-sprite--controls-play--18328",
		"raw-json": "svg-sprite--legacy-streamline-regular--programming-apps-websites--coding-files--file-code-1",
		"staging": "svg-sprite--legacy-streamline-regular--interface-essential--layouts--layout-module",
		"users": "svg-sprite--legacy-streamline-regular--users--geometric-full-body-multiple-users--multiple-users-1"
	};

	href = icons[ attributes.type ];

	include "./icon.view.cfm";

	// For CFML hierarchy purposes, allow for closing tag, but don't execute a second time.
	exit "exitTag";

</cfscript>
