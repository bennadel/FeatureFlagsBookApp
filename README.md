
# Feature Flags Book Playground

by [Ben Nadel][ben-nadel]

**STATUS: Work in Progress**

As a fun experiment, I wanted to build a small playground companion to my [Feature Flags Book][book]. This is a place where readers can log into a system and try creating feature flags and updating targeting rules to get a sense of how a feature flags / feature toggles system can be used.

[Log into the playground][app] &rarr;

## Feature Flags Data Structure

A feature flags system is really just a rules engine that takes application-provided inputs (such as `userID` or `userEmail`), funnels them through a set of rules, and then returns a predictable and repeatable result. Meaning, the same inputs will always yield the same result as long as the configured rules have not changed.

When you log into [the feature flags playground][app], your user will be allocated a unique collection of feature flags to be persisted in a JSON file. The following JavaScript represents the structure of said file.

Note: This is a **work in progress**:

```js
{
    username: "ben@bennadel.com",
    schema: 1,
    version: 13,
    createdAt: "2024-05-27T00:00:00",
    updatedAt: "2024-05-27T00:00:00",

    // The set of feature flags is shared across all environments. However,
    // each feature will have its own unique set of targeting rules.
    environments: {
        production: {
            name: "Production",
            description: ""
        },
        development: {
            name: "Development",
            description: ""
        }
    },

    features: {
        "product-TICKET-13-feature-x": {
            type: "boolean",
            description: "I determine if Feature X is enabled.",
            // The set of values that can be allocated by a given distribution.
            variants: [ false, true ],
            // The default distribution (of variants) to be used when creating
            // the environment entries.
            defaultDistribution: [ 100, 0 ],

            environments: {
                production: {
                    distribution: [ 100, 0 ],
                    // If rules aren't enabled, the distribution above is used.
                    rulesEnabled: true,
                    rules: [
                        {
                            operator: "IsOneOf",
                            input: "userID",
                            values: [ 1, 34, 99, 104 ],
                            // When a rule matches, it will override the above
                            // distribution.
                            distribution: [ 0, 100 ]
                        },
                        {
                            operator: "IsOneOf",
                            input: "companySubdomain",
                            values: [ "example", "acme" ],
                            // Or, a rule can override the actual variant (as
                            // long as the value is of the same type).
                            variant: true
                        }
                    ]
                },
                development: {
                    distribution: [ 0, 100 ],
                    rulesEnabled: false,
                    rules: []
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

* **2024, May 27**: Starting to consider data-structure of feature flag.
* **2024, May 27**: Added a light-weight authentication workflow.
* **2024, May 23**: Created repository.


[app]: https://app.featureflagsbook.com/

[ben-nadel]: https://www.bennadel.com/

[book]: https://featureflagsbook.com/