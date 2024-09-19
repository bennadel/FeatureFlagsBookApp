component
	output = false
	hint = "I provide feature flag configuration data for the demo (default data for new users)."
	{

	// Define properties for dependency-injection.
	property name="clock" ioc:type="lib.util.Clock";

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I build the feature flag entry using the given base properties. All of the features
	* will default to using a selection resolution for the first variant.
	*/
	public struct function buildFeature(
		required string type,
		required string description,
		required array variants
		) {

		return [
			type: type,
			description: description,
			variants: variants,
			defaultSelection: 1,
			targeting: [
				development: [
					resolution: [
						type: "selection",
						selection: 1
					],
					rulesEnabled: false,
					rules: []
				],
				production: [
					resolution: [
						type: "selection",
						selection: 1
					],
					rulesEnabled: false,
					rules: []
				]
			]
		];

	}


	/**
	* I provide a default configuration for the given user.
	*/
	public struct function getConfig(
		required string email,
		numeric version = 1
		) {

		var createdAt = clock.utcNow();

		return [
			email: email,
			version: version,
			createdAt: createdAt,
			updatedAt: createdAt,
			environments: [
				development: [
					name: "Development",
					description: "Development environment."
				],
				production: [
					name: "Production",
					description: "Production environment."
				]
			],
			features: [
				"product-TICKET-111-reporting": buildFeature(
					type = "boolean",
					description = "I determine if the reporting module is available.",
					variants = [ false, true ]
				),
				"product-TICKET-222-2fa": buildFeature(
					type = "boolean",
					description = "I determine if two-factor authentication (2FA) is available.",
					variants = [ false, true ]
				),
				"product-TICKET-333-themes": buildFeature(
					type = "boolean",
					description = "I determine if custom themes are available.",
					variants = [ false, true ]
				),
				"product-TICKET-444-homepage-sql-performance": buildFeature(
					type = "boolean",
					description = "I determine if an optimized SQL query should be used on the homepage.",
					variants = [ false, true ]
				),
				"product-TICKET-555-discount-pricing": buildFeature(
					type = "boolean",
					description = "I determine if the discount pricing should be applied during subscription upgrades.",
					variants = [ false, true ]
				),
				"product-TICKET-666-request-proxy": buildFeature(
					type = "boolean",
					description = "I determine if a request-proxy should be used for companies with strict Firewall rules.",
					variants = [ false, true ]
				),
				"product-TICKET-777-max-team-size": buildFeature(
					type = "number",
					description = "I determine the max number of users that can be added to a team (0 means unlimited).",
					variants = [ 0, 10, 50, 100, 1000, 10000 ]
				),
				"operations-request-rate-limit": buildFeature(
					type = "number",
					description = "I determine rate-limiting at the request-level (0 means unlimited).",
					variants = [ 0, 300 ]
				),
				"operations-user-rate-limit": buildFeature(
					type = "number",
					description = "I determine rate-limiting at the authenticated user-level (0 means unlimited).",
					variants = [ 0, 100 ]
				),
				"operations-min-log-level": buildFeature(
					type = "string",
					description = "I determine the minimum log-level to be emitted by the application.",
					variants = [ "error", "warn", "info", "debug" ]
				)
			]
		];

	}

}
