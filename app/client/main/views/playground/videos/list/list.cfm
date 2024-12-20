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
				src: "https://www.youtube.com/embed/a9tgsQAicZI?si=aLJL-WI4z67wFqDg"
			},
			{
				id: "features-clear",
				title: "Features: Remove All Rules",
				description: "This page provides a way to remove all of the rules from all of the feature flags; and resets each feature flag back to using its default selection resolution.",
				src: "https://www.youtube.com/embed/QmFD4bPXTXk?si=XWRzdaEo9wiIE8r8"
			},
			{
				id: "features-reset",
				title: "Features: Reset Demo Configuration",
				description: "This page provides a way to reset all of their feature flags playground data. This, essentially, deletes and then re-creates your demo data.",
				src: "https://www.youtube.com/embed/BouJS8BckjA?si=g7FNpSe7LWkp2499"
			},
			{
				id: "feature-targeting",
				title: "Feature: Targeting",
				description: "This page showcases the current configuration for the given feature flag across all environments. It also provides a high-level view into how the current configuration affects the variant allocation across the demo users.",
				src: "https://www.youtube.com/embed/GdVLP2y4Olc?si=Ca3TEObfZ6SCzzvV"
			},
			{
				id: "feature-default-resolution",
				title: "Feature: Default Resolution",
				description: "This page provides a way to change the default resolution for the given feature flag in the given environment. The default resolution determines how feature variants are allocated before any subsequent rules are evaluated.",
				src: "https://www.youtube.com/embed/aM1zQYcXP7o?si=XHtjHoSn_p43pTeL"
			},
			{
				id: "feature-rules-enabled",
				title: "Feature: Rules Enabled",
				description: "This page provides a way to enable or disable the rules for the given feature flag in the given environment. When rules are disabled, only the default resolution will be used when allocating feature flag variants.",
				src: "https://www.youtube.com/embed/rp81PcyUq2c?si=JnqV-GF4eKFUliNp"
			},
			{
				id: "feature-rule",
				title: "Feature: Rule",
				description: "This page provides a way to configure a rule for the given feature flag in the given environment. The rule will only be evaluated during feature flag variant allocation if rules are enabled in the given environment.",
				src: "https://www.youtube.com/embed/1akwfPJnRWA?si=YOEIOjGpSf7GXIv7"
			},
			{
				id: "feature-clear",
				title: "Feature: Clear Rules",
				description: "This page provides a way to remove all the rules from a given feature flag; and reset the feature back to using the default selection resolution.",
				src: "https://www.youtube.com/embed/ET7nQEMHi6U?si=dn7dYHooyftuo-t7"
			},
			{
				id: "feature-delete-rule",
				title: "Feature: Delete Rule",
				description: "This page provides a way to delete the given rule from the given feature flag's evaluation pipeline.",
				src: "https://www.youtube.com/embed/A_AGOCMRlAY?si=aYTTwqhsdiTNvhDm"
			},
			{
				id: "staging-matrix",
				title: "Staging: Feature Matrix",
				description: "This page provides a high-level overview of the feature flag variant allocation across all features, environments, and demo users.",
				src: "https://www.youtube.com/embed/RSToBjQ79Ws?si=xtY85l6lw3luzm1e"
			},
			{
				id: "staging-user",
				title: "Staging: User",
				description: "This page provides a high-level overview of the feature flag variant allocation for the given demo users.",
				src: "https://www.youtube.com/embed/EL9yqMshjC0?si=lsh2Uw3QXwJTWNVC"
			},
			{
				id: "staging-explain",
				title: "Staging: Variant Explanation",
				description: "This page provides a detailed explanation as to why a given variant was ultimately selected for the given feature flag, environment, and demo user.",
				src: "https://www.youtube.com/embed/rxk1RAws07s?si=P-TYxWisCrRQEIZN"
			},
			{
				id: "users",
				title: "Demo Users",
				description: "This page lists all of the demo users that can be targeted in the feature flags playground. In addition to the core set of demo users, the authenticated user is also given a team consisting of several users that all share the same email address domain.",
				src: "https://www.youtube.com/embed/k8s_wLhxheg?si=wLabm0KfDzkbUyeo"
			}
		];

	}

</cfscript>
