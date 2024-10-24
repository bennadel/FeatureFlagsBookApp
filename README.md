
# Feature Flags Book Playground

by [Ben Nadel][ben-nadel]

**STATUS: Work in Progress**

As a fun experiment, I wanted to build a small playground companion to my [Feature Flags Book][book]. This is a place where readers can log into a system and try creating feature flags and updating targeting rules to get a sense of how a feature flags / feature toggles system can be used.

[Log into the playground][app] &rarr;

[![Screenshot of Feature Flags Playground video player](./assets/demo-thumbnail@2x.jpg)](https://www.youtube.com/watch?v=5h-ozYaN8Qs)

## Feature Flags Data Structure

A feature flags system is really just a rules engine that takes application-provided inputs (such as `userID` or `userEmail`), funnels them through a set of rules, and then returns a predictable and repeatable result. Meaning, the same inputs will always yield the same result as long as the configured rules have not changed.

### Resolution Type

The majority of feature flags that I use are Boolean types that conditionally enable new feature experiments and performance improvements. For these types of flags, a finite set of variants along with a percent-based distribution makes a lot of sense &mdash; it allows you to incrementally roll-out a new feature; and, to react quickly to any early signs of a problem.

For some types of _operational_ feature flags, however, dealing with a finite set of variants and a percent-based allocation feels unnatural. In those cases, a little more flexibility creates better developer ergonomics.

To enable this kind of flexibility, each feature flag (and rule) will have a `resolution` type. This `resolution` type can be one of three flavors:

* `selection` - defines the index of the variant to be returned.

* `distribution` - defines the weighted distribution across all variants.

* `variant` - defines an override variant value (of the same type) to be returned regardless of the initial set of variants.

To demonstrate, consider the set of log-level variants:

```js
{
    variants: [ "error", "warn", "info" ]
}
```

In a production environment, we might want all users to receive the `error` variant. And, since this is the first element in the `variants` array, we could use a `selection` resolution type with value, `1`:

```js
{
    variants: [ "error", "warn", "info" ],
    targeting: {
        production: {
            resolution: {
                type: "selection",
                selection: 1 // Returns `error` for all users.
            }
        }
    }
}
```

However, in the middle of an incident, we might need to move to a lower-level of logging in order to debug the problem. However, so as to not overwhelm the log aggregation mechanism, perhaps we only want 10% of users to start emitting `warn` logs. In that case, we could use a `distribution` resolution type that allocates `error` to 90% of users, `warn` to 10% of users, and `info` to 0% of users:

```js
{
    variants: [ "error", "warn", "info" ],
    targeting: {
        production: {
            resolution: {
                type: "distribution",
                distribution: [ 90, 10, 0 ] // 10% of users get `warn`.
            }
        }
    }
}
```

Now, imagine that the defined log-level aren't enough to give us the information that we need to debug the problem. We could, in desperation, move every user to a `trace` log-level. And, since `trace` isn't in the set of predefined variants, we would use the `variant` resolution type to provide an override value:

```js
{
    variants: [ "error", "warn", "info" ],
    targeting: {
        production: {
            resolution: {
                type: "variant",
                variant: "trace" // An override value.
            }
        }
    }
}
```

### JSON Data Structure

When you log into [the feature flags playground][app], your user will be allocated a unique collection of feature flags to be persisted in a JSON file. The following JavaScript represents the structure of said file.

Note: This is a **work in progress**:

```js
{
    email: "ben@bennadel.com",
    version: 13,

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
            // The set of values that can be allocated via selection or
            // distribution resolution modes.
            variants: [ false, true ],
            // The default selection (variant index) to be used when creating
            // the environment entries.
            defaultSelection: 1,

            targeting: {
                production: {
                    resolution: {
                        type: "distribution",
                        distribution: [ 50, 50 ]
                    },
                    // If rules aren't enabled, the resolution above is used.
                    rulesEnabled: true,
                    rules: [
                        {
                            input: "group",
                            operator: "IsOneOf",
                            values: [ "beta-testers" ],
                            // When a rule matches, it will override the above
                            // resolution.
                            resolution: {
                                type: "selection",
                                selection: 2 // The `true` variant.
                            }
                        },
                        {
                            input: "companySubdomain",
                            operator: "IsOneOf",
                            values: [ "example", "acme" ],
                            // Or, a rule can override the actual variant (as
                            // long as the value is of the same type).
                            resolution: {
                                type: "variant",
                                variant: false // Never enable for matches.
                            }
                        }
                    ]
                },
                development: {
                    resolution: {
                        type: "selection",
                        selection: 2
                    },
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

You may notice that the `environments`, `features`, and `targeting` properties all reference structs. I've chosen to use structs here, instead of arrays, because they make look-ups _much easier_. For example, when checking to see if a given environment or feature exists, it's comparatively simple to perform a `keyExists(featureKey)` check rather than looping over an array and comparing element properties.

## Change Log

* **2024, July 31**: I've added a demo video link. In the longer term, I'd like to perhaps have a separate demo video on each page with "what to look for" content.

* **2024, July 29**: I've added the ability to create new feature flags, delete existing feature flags, and reset the configuration data back to the original default values.

* **2024, July 28**: I've added basic workflows for editing the core configuration data. At this point, there's still no way to add or delete a feature flag; however, you can edit all the targeting information for the existing feature flag. This should give people a better sense of how feature flags can be progressively rolled out.

* **2024, June 27**: I've added all the configuration validation methods. At this point, I should be able to start creating the UI that allows a user to actually edit their config file.

* **2024, June 10**: I starting working on the list of feature flags. The great thing about having a set of demo-users against which to evaluate the feature flags is that I can show a preview breakdown of the variant allocations. It's a bit of a brute-force &mdash; for each feature, for each environment, for all users, evaluate the variant result &mdash; but, since it's such a small number of users (in the grand scheme of things), it should be fine.

* **2024, June 9**: I collocated all of the demo targeting logic in a `DemoTargeting.cfc`. This includes both the demo rule injection and the user-context creation. This should make it a bit easier to update the demo experience in one place.

* **2024, June 8**: The evaluation grid values now link to a View that provides detailed information about why a given variant has been returned by the evaluation process.

* **2024, June 8**: I removed the `Staging` environment in the config. First, I think it's unnecessary given that there's still a `Development` and `Production` environment (having a 3rd environment just dilutes the experience). And second, I moved the "evaluator" to its own subsystem called "staging"; and, I didn't like having two different concepts in the same app with the same name.

* **2024, June 8**: I created a `debugEvaluation()` method in the client feature flag evaluation. This way, I'll be able to report to the user _why_ a given variant was selected (this is not yet implemented). I'm also continuing to iterate on the evaluation UI / experience. I think I will need to bring in [Alpine.js][alpine] to drive the event-bindings; and, possibly [Turbo CFML][turbo-cfml] to create some frame-based loading.

* **2024, June 6**: I was trying to get ChatGPT to generate demo data for me. But, it ended up being an uphill battle. In the end, I had it given me lists of first/last names. And then, I [created a script](./app/wwwroot/fake-users.cfm) to generate a large set of demo data using `randRange()`.

* **2024, June 5**: I've started working on [the client / consumer / evaluator](./app/lib/client/) portion of the playground. This would normally be an external project (in your language of choice); but, in this case, it's all part of the playground.

* **2024, June 4**: Defining some [demo data](./app/lib/demo/) that will be used to create a default experience. This includes a set of sample users against which the feature flags can be evaluated.

* **2024, June 2**: Considering the use of a `resolutionMode` in the data structure to create flexibility in which variants are returned to the user.

* **2024, May 27**: Starting to consider data-structure of feature flag.

* **2024, May 27**: Added a light-weight authentication workflow.

* **2024, May 23**: Created repository.


[app]: https://app.featureflagsbook.com/

[alpine]: https://alpinejs.dev/

[ben-nadel]: https://www.bennadel.com/

[book]: https://featureflagsbook.com/

[turbo-cfml]: https://github.com/bennadel/turbo-cfml
