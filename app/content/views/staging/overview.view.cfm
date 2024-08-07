<cfsavecontent variable="request.template.primaryContent">
	<style type="text/css">

		.state {
			border-collapse: collapse ;
			border-spacing: 0 ;
		}

		.state thead th {
			background-color: #ffffff ;
			padding: 14px 25px ;
			position: sticky ;
			top: 0 ;
			white-space: nowrap ;
			z-index: 3 ;
		}

		.state tbody th {
			background-color: #ffffff ;
			left: 0 ;
			padding: 15px 20px ;
			position: sticky ;
			white-space: nowrap ;
			z-index: 2 ;
		}

		.state thead th:after,
		.state tbody th:after {
			border: 2px solid #cccccc ;
			content: "" ;
			inset: 0 ;
			pointer-events: none ;
			position: absolute ;
		}
		.state thead th:after {
			border-width: 2px 1px 2px 1px ;
		}
		.state tbody th:after {
			border-width: 0px 2px 2px 2px ;
		}

		.state td {
			border: 1px solid #ffffff ;
			border-width: 0px 1px 1px 0px ;
			padding: 8px 20px ;
			position: relative ;
			white-space: nowrap ;
		}
		.state td.target {
			outline: 4px solid red ;
			outline-offset: -5px ;
		}
		.state .explain {
			color: inherit ;
		}
		/* Take up the entire cell surface area. */
		.state .explain:after {
			content: "" ;
			inset: 0 ;
			position: absolute ;
		}

		.feature-description {
			color: #999999 ;
			font-size: 16px ;
			margin: 0 0 10px 0 ;
			white-space: wrap ;
		}

		.feature-name {
			margin: 0 ;
		}

		.user-name {
			border: 1px dashed #cccccc ;
			margin: 0 0 15px 0 ;
			padding: 10px ;
			text-align: center ;
		}

		.user-context {
			font-size: 16px ;
			margin: 0 ;
			padding: 0 ;
			text-align: left ;
		}
		.user-context div {
			display: flex ;
			margin-block: 5px ;
		}
		.user-context div:first-child {
			margin-top: 0 ;
		}
		.user-context div:last-child {
			margin-bottom: 0 ;
		}
		.user-context dt {
			color: #999999 ;
			margin: 0 10px 0 0 ;
			padding: 0 ;
		}
		.user-context dd {
			margin: 0 ;
			padding: 0 ;
		}

		.mapper {
			border: 1px solid #33333399 ;
			border-width: 6px 0px 0px 6px ;
			bottom: 0px ;
			opacity: 0.4 ;
			position: fixed ;
			right: 0px ;
			z-index: 2 ;
		}
		.mapper table {
			border-collapse: collapse ;
			border-spacing: 0 ;
		}
		.mapper:hover {
			opacity: 1.0 ;
		}
		.mapper td {
			margin: 0 ;
			padding: 0 ;
		}
		.mapper button {
			background-color: transparent ;
			border-width: 0 ;
			cursor: pointer ;
			display: block ;
			height: 4px ;
			margin: 0 ;
			padding: 0 ;
			width: 20px ;
		}
		.mapper button:hover {
			background-color: #ffffff ;
		}

	</style>
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			&larr; <a href="/index.cfm">Back to Overview</a>
		</p>

		<p>
			<strong>Environments:</strong>

			<cfloop array="#environments#" index="environment">

				<cfif ( environment.key == url.environmentKey )>

					<a href="/index.cfm?event=staging.overview&environmentKey=#encodeForHtml( environment.key )#"><strong>#encodeForHtml( environment.name )#</strong></a>

				<cfelse>

					<a href="/index.cfm?event=staging.overview&environmentKey=#encodeForHtml( environment.key )#">#encodeForHtml( environment.name )#</a>

				</cfif>

			</cfloop>
		</p>

		<p>
			<strong>Description:</strong>
			#encodeForHtml( config.environments[ url.environmentKey ].description )#
		</p>

		<table class="state">
		<thead>
			<th scope="col">
				User
			</th>
			<cfloop array="#features#" item="feature">

				<th scope="col" valign="bottom">
					<p class="feature-description">
						#encodeForHtml( feature.description )#
					</p>

					<p class="feature-name">
						<a href="/index.cfm?event=features.targeting&featureKey=#encodeForUrl( feature.key )#">#encodeForHtml( feature.key )#</a>
					</p>
				</th>

			</cfloop>
		</thead>
		<tbody>

			<!---
				As we render the table, we're going to build-up a two-dimensional map of
				the rows and columns along with the variants. This way, at the end, we can
				render a visual map of all the evaluations.
			--->
			<cfset mapper = [] />
			<cfset mapperRowIndex = 0 />
			<cfset mapperColumnIndex = 0 />

			<cfloop array="#demoData.users#" index="demoUser">

				<cfset mapper.append( [] ) />
				<cfset mapperRowIndex++ />
				<cfset mapperColumnIndex = 0 />

				<tr>
					<th scope="row">
						<p class="user-name">
							#encodeForHtml( demoUser.name )#
						</p>

						<dl class="user-context">
							<div>
								<dt>key:</dt>
								<dd>#encodeForHtml( demoUser.id )#</dd>
							</div>
							<div>
								<dt>user.id:</dt>
								<dd>#encodeForHtml( demoUser.id )#</dd>
							</div>
							<div>
								<dt>user.email:</dt>
								<dd>#encodeForHtml( demoUser.email )#</dd>
							</div>
							<div>
								<dt>user.role:</dt>
								<dd>#encodeForHtml( demoUser.role )#</dd>
							</div>
							<div>
								<dt>user.company.id:</dt>
								<dd>#encodeForHtml( demoUser.company.id )#</dd>
							</div>
							<div>
								<dt>user.company.subdomain:</dt>
								<dd>#encodeForHtml( demoUser.company.subdomain )#</dd>
							</div>
							<div>
								<dt>user.company.fortune100:</dt>
								<dd>#encodeForHtml( demoUser.company.fortune100 )#</dd>
							</div>
							<div>
								<dt>user.company.fortune500:</dt>
								<dd>#encodeForHtml( demoUser.company.fortune500 )#</dd>
							</div>
							<div>
								<dt>user.groups.betaTester:</dt>
								<dd>#encodeForHtml( demoUser.groups.betaTester )#</dd>
							</div>
							<div>
								<dt>user.groups.influencer:</dt>
								<dd>#encodeForHtml( demoUser.groups.influencer )#</dd>
							</div>
						</dl>
					</th>
					<cfloop array="#features#" item="feature">

						<cfset mapperColumnIndex++ />

						<!---
							A feature flag has to be evaluated against a "context". The
							only required context property is "key", which is used to
							differentiate unique, targetable "clients" and to provide
							predictable percent-based allocations (by applying a modulo
							operation to a checksum of the "key"). This property, as well
							as any other custom properties, can be used within a feature
							flag's rule evaluation.

							This is the context object being provided to the targeting
							workflow:
							--
							> "key": ................... user.id,
							> "user.id": ............... user.id,
							> "user.email": ............ user.email,
							> "user.role": ............. user.role,
							> "user.company.id": ....... user.company.id,
							> "user.company.subdomain":  user.company.subdomain,
							> "user.company.fortune100": user.company.fortune100,
							> "user.company.fortune500": user.company.fortune500,
							> "user.groups.betaTester":  user.groups.betaTester,
							> "user.groups.influencer":  user.groups.influencer
							--
							Note: The dot-delimited key isn't a requirement - it's just a
							convention that I'm using to convert complex objects into
							predictable simple values.
						--->
						<cfset result = featureFlags.debugEvaluation(
							featureKey = feature.key,
							environmentKey = url.environmentKey,
							context = demoTargeting.getContext( demoUser ),
							fallbackVariant = "FALLBACK"
						) />

						<cfset variant = result.variant />
						<!---
							The index of the variant provides a way to color-code
							different values so that they are easier to discern in the
							evaluation grid.
						--->
						<cfset variantIndex = result.variantIndex />
						<cfset mapper[ mapperRowIndex ].append( variantIndex ) />

						<td
							id="state-#mapperRowIndex#-#mapperColumnIndex#"
							align="center"
							valign="center"
							class="variant-#variantIndex#">

							<a
								href="/index.cfm?event=staging.explain&userID=#encodeForUrl( demoUser.id )#&featureKey=#encodeForUrl( feature.key )#&environmentKey=#encodeForUrl( url.environmentKey )#&from=staging"
								class="explain">
								#encodeForHtml( serializeJson( variant ) )#
							</a>

						</td>

					</cfloop>
				</tr>

			</cfloop>

		</tbody>
		</table>


		<!---
			TODO: I need to clean this up. And, probably bring in Alpine.js to drive the
			event-bindings on the DOM.
		--->

		<cfset mapperRowIndex = 0 />
		<cfset mapperColumnIndex = 0 />

		<div class="mapper">
			<table>
			<cfloop array="#mapper#" index="row">
				<cfset mapperRowIndex++ />
				<cfset mapperColumnIndex = 0 />

				<tr>
					<cfloop array="#row#" index="variantIndex">
						<cfset mapperColumnIndex++ />

						<td class="variant-#variantIndex#">
							<button
								data-state="state-#mapperRowIndex#-#mapperColumnIndex#"
								class="mapper-action">
							</button>
						</td>
					</cfloop>
				</tr>
			</cfloop>
			</table>
		</div>

	</cfoutput>
	<script type="text/javascript">
		(() => {

			var mapper = document.querySelector( ".mapper" );
			var actions = mapper.querySelectorAll( ".mapper-action" );
			var stateNode = null;

			for ( var action of actions ) {

				action.addEventListener( "click", handleActionClick );

			}

			function handleActionClick( event ) {

				var target = event.currentTarget;
				var state = target.dataset.state;

				if ( stateNode ) {

					stateNode.classList.remove( "target" );

				}

				stateNode = document.querySelector( `#${ state }` );
				stateNode.classList.add( "target" );
				stateNode.scrollIntoView({
					behavior: "smooth",
					block: "center",
					inline: "center"
				});

			}

		})();

	</script>
</cfsavecontent>
