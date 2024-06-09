component
	output = false
	hint = "I provide targeting-related information about the request context and the feature flag configuration."
	{

	/**
	* I provide a targeting context for the given user.
	*/
	public struct function getContext( required struct user ) {

		return [
			"key": user.id,
			"user.id": user.id,
			"user.email": user.email,
			"user.role": user.role,
			"user.company.id": user.company.id,
			"user.company.subdomain": user.company.subdomain,
			"user.company.fortune100": user.company.fortune100,
			"user.company.fortune500": user.company.fortune500,
			"user.groups.betaTester": user.groups.betaTester,
			"user.groups.influencer": user.groups.influencer
		];

	}


	/**
	* I apply rules to the given demo data in order to make the demo more interesting for
	* the user without them having to mess with the targeting rules.
	*/
	public struct function injectRules( required struct config ) {

		// Flip some flags on to vary the rendering.
		config.features[ "operations-request-rate-limit" ].environments.development.resolution = {
			type: "variant",
			variant: 100
		};
		config.features[ "product-TICKET-111-reporting" ].environments.development.resolution = {
			type: "Distribution",
			distribution: [ 50, 50 ]
		};
		config.features[ "product-TICKET-222-2fa" ].environments.production.resolution = {
			type: "Selection",
			selection: 2
		};
		config.features[ "product-TICKET-444-homepage-sql-performance" ].environments.production.resolution = {
			type: "Distribution",
			distribution: [ 95, 5 ]
		};
		config.features[ "product-TICKET-444-homepage-sql-performance" ].environments.development.rulesEnabled = true;
		config.features[ "product-TICKET-444-homepage-sql-performance" ].environments.development.rules.append({
			operator: "IsOneOf",
			input: "user.company.subdomain",
			values: [ "innovatek", "starcorp" ],
			resolution: {
				type: "Selection",
				selection: 2
			}
		});
		config.features[ "product-TICKET-555-discount-pricing" ].environments.production.rulesEnabled = true;
		config.features[ "product-TICKET-555-discount-pricing" ].environments.production.rules.append({
			operator: "IsOneOf",
			input: "user.groups.influencer",
			values: [ true ],
			resolution: {
				type: "Selection",
				selection: 2
			}
		});

		return config;

	}

}
