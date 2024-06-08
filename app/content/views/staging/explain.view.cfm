<cfsavecontent variable="request.template.primaryContent">
	<style type="text/css">

		.dump-wrapper {
			margin: 20px 0px 26px 0px ;
		}
		.dump-wrapper th,
		.dump-wrapper td {
			font-family: monospace ! important ;
			font-size: 20px ! important ;
		}

	</style>
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			<strong>Feature:</strong>
			#encodeForHtml( url.featureName )#
		</p>

		<p>
			<strong>Environment:</strong>
			#encodeForHtml( url.environmentName )#
		</p>

		<p>
			<strong>Variant:</strong>
			#encodeForHtml( serializeJson( result.variant ) )#
		</p>

		<p>
			<strong>Variant Index:</strong>
			#result.variantIndex#

			<cfif ! result.variantIndex>
				&mdash; "0" means either custom override or fallback.
			</cfif>
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
					the variant was chosen using the feature's default resolution strategy

					<cfif result.feature.environments[ url.environmentName ].rulesEnabled>
						(this is because no rules matched against the given context).
					<cfelse>
						(this is because rules are not enabled).
					</cfif>
				</cfcase>
				<cfcase value="MatchingRule">
					a rule matched against the given context and provided an alternative resolution.
				</cfcase>
				<cfcase value="Error">
					an error occurred. As such, the fallback variant is being used.
				</cfcase>
				<cfdefaultcase>
					Something unexpected happened.
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
				<strong>Name:</strong>
				#encodeForHtml( url.featureName )#
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
				<strong>Environment Settings:</strong>
			</p>

			<div class="dump-wrapper">
				<cfdump var="#result.feature.environments#" />
			</div>

		</cfif>

	</cfoutput>
</cfsavecontent>
