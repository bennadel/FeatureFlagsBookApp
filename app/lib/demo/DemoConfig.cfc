component
	output = false
	hint = "I provide feature flag configuration data for the demo (default data for new users)."
	{

	/**
	* I provide a default subset of configuration settings.
	*/
	public struct function getConfig() {

		return {
			environments: [
				development: {
					name: "Development",
					description: "Development environment."
				},
				production: {
					name: "Production",
					description: "Production environment."
				}
			],
			features: {
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
					description = "I determine if an alternate SQL query should be used on the homepage.",
					variants = [ false, true ]
				),
				"product-TICKET-555-discount-pricing": buildFeature(
					type = "boolean",
					description = "I determine if the discount pricing should be applied during upgrade.",
					variants = [ false, true ]
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
					variants = [ "error", "warn", "info", "debug", "trace" ]
				)
			}
		};

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I build the feature flag entry using the given base properties. All of the features
	* will default to using a selection resolution for the first variant.
	*/
	private struct function buildFeature(
		required string type,
		required string description,
		required array variants
		) {

		return {
			type: type,
			description: description,
			variants: variants,
			defaultSelection: 1,
			environments: {
				development: {
					resolution: {
						type: "selection",
						selection: 1
					},
					rulesEnabled: false,
					rules: []
				},
				production: {
					resolution: {
						type: "selection",
						selection: 1
					},
					rulesEnabled: false,
					rules: []
				}
			}
		};

	}

}
