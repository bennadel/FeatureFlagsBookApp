<cfsavecontent variable="request.template.primaryContent">
	<style type="text/css">

		.dump-wrapper {
			margin: 20px 0px 26px 0px ;
		}
		.dump-wrapper th,
		.dump-wrapper td {
			font-family: monospace ! important ;
			font-size: 20px ! important ;
			padding: 7px 10px ! important ;
		}

	</style>
	<cfoutput>

		<section class="content-wrapper u-collapse-margin">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p>
				<strong>User:</strong>
				<a href="/index.cfm?event=playground.staging.user&userID=#encodeForUrl( user.id )#">#encodeForHtml( user.email )#</a>
			</p>

			<p>
				<strong>Feature:</strong>
				<a href="/index.cfm?event=playground.features.detail.targeting&featureKey=#encodeForHtml( feature.key )#">#encodeForHtml( feature.key )#</a>
			</p>

			<p>
				<strong>Environment:</strong>
				<a href="/index.cfm?event=playground.staging.matrix&environmentKey=#encodeForHtml( environment.key )#">#encodeForHtml( environment.key )#</a>
			</p>

			<p>
				<strong>Variant:</strong>
				<span class="tag variant-#result.variantIndex#">#encodeForHtml( serializeJson( result.variant ) )#</span>

				<cfif ! result.variantIndex>
					<cfif ( result.reason == "Error" )>
						&mdash; fallback value was used due to an error.
					<cfelse>
						&mdash; a custom variant was used.
					</cfif>
				</cfif>
			</p>

			<p>
				<strong>Reason:</strong>
				<mark>#encodeForHtml( result.reason )#</mark>
			</p>

			<hr />

			<h2>
				Context
			</h2>

			<div class="dump-wrapper">
				<cfdump var="#result.arguments.context#" />
			</div>

			<hr />

			<h2>
				Targeting Details
			</h2>

			<p>
				<strong>Reason:</strong>
				<mark>#encodeForHtml( result.reason )#</mark> &mdash;

				<cfswitch expression="#result.reason#">
					<!---
						Note: The two key-related cases aren't actually possible in this
						application (since the context objects are all being hard-coded in the
						application logic). But, I'm including them here for anyone that might
						view the source code and wants to better understand the targeting
						requirements for feature flag state evaluation.
					--->
					<cfcase value="MissingContextKey">
						your context struct must contain a `key` that associates the current request with a targetable entity (such as a user, machine host, ip address, application name, etc). Since you aren't providing a `key`, the fallback variant is being used.
					</cfcase>
					<cfcase value="ComplexContextKey">
						the context `key` property associated with the current request is a complex object and must be a simple value (string). This simple value is used to drive percent-based variant allocations and other targeting rules. Since you aren't providing a proper `key`, the fallback variant is being used.
					</cfcase>
					<!--- End: Cases that never happen in this app. --->
					<cfcase value="EmptyConfig">
						your configuration is empty (it has no feature flags). As such, the fallback variant is being used.
					</cfcase>
					<cfcase value="MissingFeature">
						your configuration does not contain the given feature key. As such, the fallback variant is being used.
					</cfcase>
					<cfcase value="MissingEnvironment">
						your configuration does not contain the given environment key. As such, the fallback variant is being used.
					</cfcase>
					<cfcase value="DefaultResolution">
						the variant was chosen using the feature's default resolution strategy.

						<cfif result.feature.targeting[ environment.key ].rulesEnabled>
							This is because no rules matched against the given context.
						<cfelse>
							This is because rules are not enabled.
						</cfif>
					</cfcase>
					<cfcase value="MatchingRule">
						a rule matched against the given context and provided an alternative resolution. The variant was chosen using this alternative resolution strategy.
					</cfcase>
					<cfcase value="Error">
						an error occurred. As such, the fallback variant is being used.
					</cfcase>
					<cfdefaultcase>
						Something unexpected happened. This state should not be possible.
					</cfdefaultcase>
				</cfswitch>
			</p>

			<cfif result.errorMessage.len()>
				<strong>Error:</strong>
				#encodeForHtml( result.errorMessage )#
			</cfif>

			<cfif ( result.reason == "MatchingRule" )>

				<p>
					<strong>Matching Rule:</strong>
				</p>

				<div class="dump-wrapper">
					<cfdump var="#result.evaluatedRules.last()#" />
				</div>

			</cfif>

			<cfif isStruct( result.resolution )>

				<p>
					<strong>Resolution:</strong> The following resolution strategy was used to select the variant.
				</p>

				<div class="dump-wrapper">
					<cfdump var="#result.resolution#" />
				</div>

			</cfif>

			<cfif isArray( result.evaluatedRules )>

				<p>
					<strong>Evaluated Rules:</strong> The following rules were evaluated as part of the targeting.
				</p>

				<div class="dump-wrapper">
					<cfdump var="#result.evaluatedRules#" />
				</div>

			</cfif>

			<cfif isArray( result.skippedRules )>

				<p>
					<strong>Skipped Rules:</strong> The following rules were skipped while targeting (due to a mismatch in keys and/or data types).
				</p>

				<div class="dump-wrapper">
					<cfdump var="#result.skippedRules#" />
				</div>

			</cfif>

			<cfif isStruct( result.feature )>

				<hr />

				<h2>
					Feature Configuration
				</h2>

				<p>
					<strong>Key:</strong>
					#encodeForHtml( feature.key )#
				</p>

				<p>
					<strong>Description:</strong>
					#encodeForHtml( result.feature.description )#
				</p>

				<p>
					<strong>Type:</strong>
					#encodeForHtml( result.feature.type )#
				</p>

				<p>
					<strong>Variants:</strong>
				</p>

				<div class="dump-wrapper">
					<cfdump var="#result.feature.variants#" />
				</div>

				<p>
					<strong>Targeting Settings:</strong>
				</p>

				<div class="dump-wrapper">
					<cfdump var="#result.feature.targeting#" />
				</div>

			</cfif>

		</section>

	</cfoutput>
</cfsavecontent>
