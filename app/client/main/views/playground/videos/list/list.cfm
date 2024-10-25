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
				description: "This page illustrates the way in which feature flags can be woven into a team's product development workflow. By separating the concept of deployment from the concept of release, it gives the engineering, product, and design teams a way to safely iterate on a feature in production. And then, gradually release the feature to an increasingly wider audience.",
				src: "https://www.youtube.com/embed/IZehOBHjslw?si=0KCl9mNn24o2LwkW"
			},
			{
				id: "features-list",
				title: "Features: List",
				description: "This page provides a high-level overview of the current feature flags, including the relative distribution of each feature flag variant across the demo users and environments. Additionally, any feature flags that are serving the same variant in all environments are highlighted for removal.",
				src: "https://www.youtube.com/embed/lFQ2U5Hirfw?si=fozJxTqLECUkMMXi"
			},
			{
				id: "features-create",
				title: "Features: Create New Feature Flag",
				description: "This page provides a way to create a new feature flag with a default selection resolution. Any additional targeting can be defined after the feature flag is created.",
				src: ""
			},
			{
				id: "features-clear",
				title: "Features: Remove All Rules",
				description: "This page provides a way to remove all of the rules from all of the feature flags; and resets each feature flag back to using its default selection resolution.",
				src: ""
			},
			{
				id: "features-reset",
				title: "Features: Reset Demo Configuration",
				description: "This page allows provides a way to reset all of their feature flags playground data. This, essentially, deletes and then re-creates your demo data.",
				src: ""
			},
			{
				id: "feature-targeting",
				title: "Feature: Targeting",
				description: "This page showcases the current configuration for the given feature flag across all environments. It also provides a high-level view into how the current configuration affects the variant allocation across the demo users.",
				src: ""
			},
			{
				id: "feature-default-resolution",
				title: "Feature: Default Resolution",
				description: "This page provides a way to change the default resolution for the given feature flag in the given environment. The default resolution determines how feature variants are allocated before any subsequent rules are evaluated.",
				src: ""
			},
			{
				id: "feature-rules-enabled",
				title: "Feature: Rules Enabled",
				description: "This page provides a way to enable or disable the rules for the given feature flag in the given environment. When rules are disabled, only the default resolution will be used when allocating feature flag variants.",
				src: ""
			},
			{
				id: "feature-rule",
				title: "Feature: Rule",
				description: "This page provides a way to configure a rule for the given feature flag in the given environment. The rule will only be evaluated during feature flag variant allocation if rules are enabled in the given environment.",
				src: ""
			},
			{
				id: "feature-clear",
				title: "Feature: Clear Rules",
				description: "This page provides a way to remove all the rules from a given feature flag; and reset the feature back to using the default selection resolution.",
				src: ""
			},
			{
				id: "feature-delete-rule",
				title: "Feature: Delete Rule",
				description: "This page provides a way to delete the given rule from the given feature flag's evaluation pipeline.",
				src: ""
			},
			{
				id: "staging-matrix",
				title: "Staging: Feature Matrix",
				description: "This page provides a high-level overview of the feature flag variant allocation across all features, environments, and demo users.",
				src: ""
			},
			{
				id: "staging-user",
				title: "Staging: User",
				description: "This page provides a high-level overview of the feature flag variant allocation for the given demo users.",
				src: ""
			},
			{
				id: "staging-explain",
				title: "Staging: Variant Explanation",
				description: "This page provides a detailed explanation as to why a given variant was ultimately selected for the given feature flag, environment, and demo user.",
				src: ""
			},
			{
				id: "users",
				title: "Demo Users",
				description: "This page lists all of the demo users that can be targeted in the feature flags playground. In addition to the core set of demo users, the authenticated user is also given a team consisting of several users that all share the same email address domain.",
				src: ""
			}
		];

	}

</cfscript>
