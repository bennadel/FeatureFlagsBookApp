
# Feature Flags Book Playground

by [Ben Nadel][ben-nadel]

**STATUS: Work in Progress**

As a fun experiment, I wanted to build a small playground companion to my [Feature Flags Book][book]. This is a place where readers can log into a system and try creating feature flags and updating targeting rules to get a sense of how a feature flags / feature toggles system can be used.

## Feature Flags Data Structure

A feature flags system is really just a rules engine that takes application-provided inputs (such as `userID` or `userEmail`), compares them to a set of filters, and then returns a predictable and repeatable value. Meaning, the same inputs will always yield the same output as long as the configured filters do not change.

The following JSON payload represents the feature flags configuration for a given user.

This is a **work in progress**&mdash;I'm thinking out loud about what I want the configuration to look like:

```json
{
	"username": "ben@bennadel.com",
	"schema": 1,
	"version": 13,
	"createdAt": "2024-05-27T00:00:00",
	"updatedAt": "2024-05-27T00:00:00",
	// Each feature has environment-specific rules.
	"environments": [
		{
			"id": "production",
			"name": "Production"
		},
		{
			"id": "development",
			"name": "Development"
		}
	],
	"features": {
		"product-TICKET-13-feature-x": {
			"type": "boolean",
			"description": "I determine if Feature X is enabled.",
			"variants": [ false, true ],
			// Used when creating the environment entries.
			"defaultDistribution": [ 100, 0 ],
			"environments": {
				"production": {
					"distribution": [ 100, 0 ],
					// If rules aren't enabled, above distribution is used.
					"rulesEnabled": true,
					"rules": [
						{
							"operator": "IsOneOf",
							"input": "userID",
							"values": [ 1 ],
							// A rule can override the above distribution.
							"distribution": [ 0, 100 ]
						},
						{
							"operator": "IsOneOf",
							"input": "companySubdomain",
							"values": [ "example" ],
							// Or, a rule can override the actual variant.
							"variant": true
						}
					]
				},
				"development": {
					"distribution": [ 0, 100 ],
					"rulesEnabled": false,
					"rules": []
				}
			}
		},
		"operations-ip-rate-limit": {
			// ....
		}
	}
}
```

## Change Log

* **2024, May 27**: Added a light-weight authentication workflow.
* **2024, May 23**: Created repository.


[ben-nadel]: https://www.bennadel.com/

[book]: https://featureflagsbook.com/