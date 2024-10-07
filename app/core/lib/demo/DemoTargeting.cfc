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
	* I return the unique set of values that can be attributed to each targeting facet.
	*/
	public struct function getDatalists( required array users ) {

		var datalists = [
			"key": [:],
			"user.id": [:],
			"user.email": [:],
			"user.emailDomain": [:], // Special case.
			"user.role": [:],
			"user.company.id": [:],
			"user.company.subdomain": [:],
			"user.company.fortune100": [:],
			"user.company.fortune500": [:],
			"user.groups.betaTester": [:],
			"user.groups.influencer": [:]
		];

		for ( var user in users ) {

			datalists[ "key" ][ user.id ] = true;
			datalists[ "user.id" ][ user.id ] = true;
			datalists[ "user.email" ][ user.email ] = true;
			datalists[ "user.emailDomain" ][ "@" & user.email.listRest( "@" ) ] = true;
			datalists[ "user.role" ][ user.role ] = true;
			datalists[ "user.company.id" ][ user.company.id ] = true;
			datalists[ "user.company.subdomain" ][ user.company.subdomain ] = true;
			datalists[ "user.company.fortune100" ][ user.company.fortune100 ] = true;
			datalists[ "user.company.fortune500" ][ user.company.fortune500 ] = true;
			datalists[ "user.groups.betaTester" ][ user.groups.betaTester ] = true;
			datalists[ "user.groups.influencer" ][ user.groups.influencer ] = true;

		}

		for ( var key in datalists.keyArray() ) {

			switch ( key ) {
				case "key":
				case "user.id":
				case "user.company.id":
					var sortType = "numeric";
				break;
				default:
					var sortType = "textnocase";
				break;
			}

			datalists[ key ] = datalists[ key ].keyArray().sort( sortType );

		}

		return datalists;

	}


	/**
	* I get the list of available inputs.
	*/
	public array function getInputs() {

		return [
			"key",
			"user.id",
			"user.email",
			"user.role",
			"user.company.id",
			"user.company.subdomain",
			"user.company.fortune100",
			"user.company.fortune500",
			"user.groups.betaTester",
			"user.groups.influencer"
		];

	}


	/**
	* I get the list of available operators.
	*/
	public array function getOperators() {

		return [
			"Contains",
			"EndsWith",
			"IsOneOf",
			"MatchesPattern",
			"NotContains",
			"NotEndsWith",
			"NotIsOneOf",
			"NotMatchesPattern",
			"NotStartsWith",
			"StartsWith"
		];

	}


	/**
	* I apply rules to the given demo data in order to make the demo more interesting for
	* the user without them having to mess with the targeting rules.
	*/
	public struct function injectRules( required struct config ) {

		// Default enabled in development.
		config.features[ "product-TICKET-111-reporting" ].targeting.development.resolution = [
			type: "selection",
			selection: 2
		];
		config.features[ "product-TICKET-111-reporting" ].targeting.production.rulesEnabled = true;
		// Enabled in production for selected companies.
		config.features[ "product-TICKET-111-reporting" ].targeting.production.rules.append([
			operator: "IsOneOf",
			input: "user.company.subdomain",
			values: [ "fusionworks", "techgenius", "primetech" ],
			resolution: [
				type: "selection",
				selection: 2
			]
		]);
		// Enabled in production for all tech-media influencers.
		config.features[ "product-TICKET-111-reporting" ].targeting.production.rules.append([
			operator: "IsOneOf",
			input: "user.groups.influencer",
			values: [ true ],
			resolution: [
				type: "selection",
				selection: 2
			]
		]);

		// Default disabled in development where we haven't integrated the auth-provider.
		// Default enabled in production.
		config.features[ "product-TICKET-222-2fa" ].targeting.production.resolution = [
			type: "selection",
			selection: 2
		];
		// Disable selectively for a few companies.
		config.features[ "product-TICKET-222-2fa" ].targeting.production.rulesEnabled = true;
		config.features[ "product-TICKET-222-2fa" ].targeting.production.rules.append([
			operator: "IsOneOf",
			input: "user.company.subdomain",
			values: [ "techgenius" ],
			resolution: [
				type: "selection",
				selection: 1
			]
		]);

		// Default enabled in development.
		config.features[ "product-TICKET-333-themes" ].targeting.development.resolution = [
			type: "selection",
			selection: 2
		];
		config.features[ "product-TICKET-333-themes" ].targeting.production.rulesEnabled = true;
		// Enabled in production for all tech-media influencers.
		config.features[ "product-TICKET-333-themes" ].targeting.production.rules.append([
			operator: "IsOneOf",
			input: "user.groups.influencer",
			values: [ true ],
			resolution: [
				type: "selection",
				selection: 2
			]
		]);
		// Enabled in production for all beta-testers.
		config.features[ "product-TICKET-333-themes" ].targeting.production.rules.append([
			operator: "IsOneOf",
			input: "user.groups.betaTester",
			values: [ true ],
			resolution: [
				type: "selection",
				selection: 2
			]
		]);
		// Enabled in production for selected companies.
		config.features[ "product-TICKET-333-themes" ].targeting.production.rules.append([
			operator: "IsOneOf",
			input: "user.company.subdomain",
			values: [ "futuretech", "innovaplex", "quantumsoft", "starcorp", "ultralink" ],
			resolution: [
				type: "selection",
				selection: 2
			]
		]);

		// Default enabled in development.
		config.features[ "product-TICKET-444-homepage-sql-performance" ].targeting.development.resolution = [
			type: "selection",
			selection: 2
		];
		// In production, slowly roll-out to a few customers.
		config.features[ "product-TICKET-444-homepage-sql-performance" ].targeting.production.resolution = [
			type: "distribution",
			distribution: [ 90, 10 ]
		];

		// Default disabled in development.
		config.features[ "product-TICKET-555-discount-pricing" ].targeting.production.rulesEnabled = true;
		// In production, selectively enable for tech-media influencers.
		config.features[ "product-TICKET-555-discount-pricing" ].targeting.production.rules.append([
			operator: "IsOneOf",
			input: "user.groups.influencer",
			values: [ true ],
			resolution: [
				type: "selection",
				selection: 2
			]
		]);
		// In production, selectively enable for a few email domains.
		config.features[ "product-TICKET-555-discount-pricing" ].targeting.production.rules.append([
			operator: "EndsWith",
			input: "user.email",
			values: [ "@nexsol.example.com" ],
			resolution: [
				type: "selection",
				selection: 2
			]
		]);

		// Default disabled in development.
		config.features[ "product-TICKET-666-request-proxy" ].targeting.production.rulesEnabled = true;
		// In production, selectively enable for a few companies.
		config.features[ "product-TICKET-666-request-proxy" ].targeting.production.rules.append([
			operator: "IsOneOf",
			input: "user.company.subdomain",
			values: [ "megacorp" ],
			resolution: [
				type: "selection",
				selection: 2
			]
		]);

		// Default to a small size in development.
		config.features[ "product-TICKET-777-max-team-size" ].targeting.development.resolution = [
			type: "selection",
			selection: 2
		];
		// Default to a reasonable size in development.
		config.features[ "product-TICKET-777-max-team-size" ].targeting.production.resolution = [
			type: "selection",
			selection: 3
		];
		config.features[ "product-TICKET-777-max-team-size" ].targeting.production.rulesEnabled = true;
		// For fortune 500 companies, make it really high.
		config.features[ "product-TICKET-777-max-team-size" ].targeting.production.rules.append([
			operator: "IsOneOf",
			input: "user.company.fortune500",
			values: [ true ],
			resolution: [
				type: "selection",
				selection: 6
			]
		]);
		// For fortune 100 companies, make it (essentially) unlimited.
		config.features[ "product-TICKET-777-max-team-size" ].targeting.production.rules.append([
			operator: "IsOneOf",
			input: "user.company.fortune100",
			values: [ true ],
			resolution: [
				type: "variant",
				variant: 999999999
			]
		]);

		// We want this feature to appear "uniform" in all environments so that it is
		// suggested as a feature to remove.
		config.features[ "product-TICKET-888-branding-refresh" ].targeting.development.resolution = [
			type: "selection",
			selection: 2
		];
		config.features[ "product-TICKET-888-branding-refresh" ].targeting.production.resolution = [
			type: "selection",
			selection: 2
		];

		// Default to unlimited in development.
		// Default to a reasonable measure in production.
		config.features[ "operations-request-rate-limit" ].targeting.production.resolution = [
			type: "selection",
			selection: 2
		];
		// Raise up for a select set of companies which have a huge number of users behind
		// a single IP-address.
		config.features[ "operations-request-rate-limit" ].targeting.production.rulesEnabled = true;
		config.features[ "operations-request-rate-limit" ].targeting.production.rules.append([
			operator: "IsOneOf",
			input: "user.company.subdomain",
			values: [ "quantumsoft" ],
			resolution: [
				type: "variant",
				variant: 750
			]
		]);
		config.features[ "operations-request-rate-limit" ].targeting.production.rules.append([
			operator: "IsOneOf",
			input: "user.company.subdomain",
			values: [ "ultralink" ],
			resolution: [
				type: "variant",
				variant: 1000
			]
		]);

		// Default to unlimited in development.
		// Default to a reasonable measure in production.
		config.features[ "operations-user-rate-limit" ].targeting.production.resolution = [
			type: "selection",
			selection: 2
		];

		// Default to trace in development.
		config.features[ "operations-min-log-level" ].targeting.development.resolution = [
			type: "variant",
			variant: "trace"
		];
		// Default to error in production.
		config.features[ "operations-min-log-level" ].targeting.production.resolution = [
			type: "selection",
			selection: 1
		];

		return config;

	}

}
