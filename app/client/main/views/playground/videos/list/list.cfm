<cfscript>

	requestHelper = request.ioc.get( "client.main.lib.RequestHelper" );
	requestMetadata = request.ioc.get( "core.lib.RequestMetadata" );
	ui = request.ioc.get( "client.main.lib.ViewHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="request.context.returnTo" type="string" default="";
	param name="request.context.videoID" type="string" default="";

	title = "Video Commentary";
	videos = getVideos();
	returnToUrl = getReturnToUrl( request.context.returnTo );

	request.template.title = title;

	include "./list.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the return to url; but, only if it's an internal URL.
	*/
	private string function getReturnToUrl( required string returnTo ) {

		return requestMetadata.isInternalUrl( returnTo )
			? returnTo
			: ""
		;

	}

	/**
	* I get the list of videos.
	*/
	private array function getVideos() {

		return [
			{
				id: "walk-through",
				title: "Features: Product Development Walk-Through",
				description: "Coming soon....",
				url: ""
			},
			{
				id: "features-list",
				title: "Features: List",
				description: "Coming soon....",
				url: ""
			},
			{
				id: "features-create",
				title: "Features: Create New Feature Flag",
				description: "Coming soon....",
				url: ""
			},
			{
				id: "features-clear",
				title: "Features: Remove All Rules",
				description: "Coming soon....",
				url: ""
			},
			{
				id: "features-reset",
				title: "Features: Reset Demo Configuration",
				description: "Coming soon....",
				url: ""
			},
			{
				id: "feature-targeting",
				title: "Feature: Targeting",
				description: "Coming soon....",
				url: ""
			},
			{
				id: "feature-default-resolution",
				title: "Feature: Default Resolution",
				description: "Coming soon....",
				url: ""
			},
			{
				id: "feature-rules-enabled",
				title: "Feature: Rules Enabled",
				description: "Coming soon....",
				url: ""
			},
			{
				id: "feature-rule",
				title: "Feature: Rule",
				description: "Coming soon....",
				url: ""
			},
			{
				id: "feature-clear",
				title: "Feature: Clear Rules",
				description: "Coming soon....",
				url: ""
			},
			{
				id: "feature-delete-rule",
				title: "Feature: Delete Rule",
				description: "Coming soon....",
				url: ""
			},
			{
				id: "staging-matrix",
				title: "Staging: Feature Matrix",
				description: "Coming soon....",
				url: ""
			},
			{
				id: "staging-user",
				title: "Staging: User",
				description: "Coming soon....",
				url: ""
			},
			{
				id: "staging-explain",
				title: "Staging: Variant Explanation",
				description: "Coming soon....",
				url: ""
			},
			{
				id: "users",
				title: "Demo Users",
				description: "Coming soon....",
				url: ""
			}
		];

	}

</cfscript>
