<cfscript>

	title = "Ask a Question";
	chapters = getChapters();

	request.template.title = title;

	include "./chapters.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the chapters in the book with links to blog posts.
	*/
	private array function getChapters() {

		return [
			{
				title: "Of Outages And Incidents",
				href: "https://www.bennadel.com/blog/4540-feature-flags-book-of-outages-and-incidents.htm"
			},
			{
				title: "The Status Quo",
				href: "https://www.bennadel.com/blog/4541-feature-flags-book-the-status-quo.htm"
			},
			{
				title: "Feature Flags, An Introduction",
				href: "https://www.bennadel.com/blog/4542-feature-flags-book-feature-flags-an-introduction.htm"
			},
			{
				title: "Key Terms And Concepts",
				href: "https://www.bennadel.com/blog/4543-feature-flags-book-key-terms-and-concepts.htm"
			},
			{
				title: "Going Deep On Feature Flag Targeting",
				href: "https://www.bennadel.com/blog/4544-feature-flags-book-going-deep-on-feature-flag-targeting.htm"
			},
			{
				title: "The User Experience (UX) Of Feature Flag Targeting",
				href: "https://www.bennadel.com/blog/4545-feature-flags-book-the-user-experience-ux-of-feature-flag-targeting.htm"
			},
			{
				title: "Types Of Feature Flags",
				href: "https://www.bennadel.com/blog/4546-feature-flags-book-types-of-feature-flags.htm"
			},
			{
				title: "Life-Cycle Of A Feature Flag",
				href: "https://www.bennadel.com/blog/4547-feature-flags-book-life-cycle-of-a-feature-flag.htm"
			},
			{
				title: "Use Cases",
				href: "https://www.bennadel.com/blog/4548-feature-flags-book-use-cases.htm"
			},
			{
				title: "Server-Side vs. Client-Side",
				href: "https://www.bennadel.com/blog/4549-feature-flags-book-server-side-vs-client-side.htm"
			},
			{
				title: "Bridging The Sophistication Gap",
				href: "https://www.bennadel.com/blog/4550-feature-flags-book-bridging-the-sophistication-gap.htm"
			},
			{
				title: "Life Without Automated Testing",
				href: "https://www.bennadel.com/blog/4551-feature-flags-book-life-without-automated-testing.htm"
			},
			{
				title: "Ownership Boundaries",
				href: "https://www.bennadel.com/blog/4552-feature-flags-book-ownership-boundaries.htm"
			},
			{
				title: "The Hidden Cost Of Feature Flags",
				href: "https://www.bennadel.com/blog/4553-feature-flags-book-the-hidden-cost-of-feature-flags.htm"
			},
			{
				title: "Not Everything Can Be Feature Flagged",
				href: "https://www.bennadel.com/blog/4554-feature-flags-book-not-everything-can-be-feature-flagged.htm"
			},
			{
				title: "Build vs. Buy",
				href: "https://www.bennadel.com/blog/4555-feature-flags-book-build-vs-buy.htm"
			},
			{
				title: "Track Actions, Not Feature Flag State",
				href: "https://www.bennadel.com/blog/4556-feature-flags-book-track-actions-not-feature-flag-state.htm"
			},
			{
				title: "Logs, Metrics, And Feature Flags",
				href: "https://www.bennadel.com/blog/4557-feature-flags-book-logs-metrics-and-feature-flags.htm"
			},
			{
				title: "Transforming Your Company Culture",
				href: "https://www.bennadel.com/blog/4558-feature-flags-book-transforming-your-company-culture.htm"
			},
			{
				title: "People Like Us Do Things Like This",
				href: "https://www.bennadel.com/blog/4559-feature-flags-book-people-like-us-do-things-like-this.htm"
			},
			{
				title: "Building Inclusive Products",
				href: "https://www.bennadel.com/blog/4560-feature-flags-book-building-inclusive-products.htm"
			},
			{
				title: "An Opinionated Guide To Pull Requests (PRs)",
				href: "https://www.bennadel.com/blog/4561-feature-flags-book-an-opinionated-guide-to-pull-requests-prs.htm"
			},
			{
				title: "Removing The Cost Of Context Switching",
				href: "https://www.bennadel.com/blog/4562-feature-flags-book-removing-the-cost-of-context-switching.htm"
			},
			{
				title: "Measuring Team Productivity",
				href: "https://www.bennadel.com/blog/4563-feature-flags-book-measuring-team-productivity.htm"
			},
			{
				title: "Increasing Agility With Dynamic Code",
				href: "https://www.bennadel.com/blog/4564-feature-flags-book-increasing-agility-with-dynamic-code.htm"
			},
			{
				title: "Product Release vs. Marketing Release",
				href: "https://www.bennadel.com/blog/4565-feature-flags-book-product-release-vs-marketing-release.htm"
			},
			{
				title: "Getting From No To Yes",
				href: "https://www.bennadel.com/blog/4566-feature-flags-book-getting-from-no-to-yes.htm"
			},
			{
				title: "What If I Can Only Deploy Every 2 Weeks?",
				href: "https://www.bennadel.com/blog/4567-feature-flags-book-what-if-i-can-only-deploy-every-2-weeks.htm"
			},
			{
				title: "I Eat, I Sleep, I Feature Flag",
				href: "https://www.bennadel.com/blog/4568-feature-flags-book-i-eat-i-sleep-i-feature-flag.htm"
			}
		];

	}

</cfscript>
