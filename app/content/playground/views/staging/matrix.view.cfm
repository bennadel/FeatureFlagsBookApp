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

		<section class="content-wrapper u-collapse-margin">

			<h1>
				#encodeForHtml( partial.title )#
			</h1>

			<p>
				<strong>Environments:</strong>

				<cfloop array="#partial.environments#" index="environment">

					<cfif ( environment.key == url.environmentKey )>

						<a href="/index.cfm?event=playground.staging.matrix&environmentKey=#encodeForHtml( environment.key )#"><strong>#encodeForHtml( environment.name )#</strong></a>

					<cfelse>

						<a href="/index.cfm?event=playground.staging.matrix&environmentKey=#encodeForHtml( environment.key )#">#encodeForHtml( environment.name )#</a>

					</cfif>

				</cfloop>
			</p>

			<table class="state">
			<thead>
				<th scope="col">
					User
				</th>
				<cfloop array="#partial.features#" item="feature">

					<th scope="col" valign="bottom">
						<p class="feature-description">
							#encodeForHtml( feature.description )#
						</p>

						<p class="feature-name">
							<a href="/index.cfm?event=playground.features.targeting&featureKey=#encodeForUrl( feature.key )#">#encodeForHtml( feature.key )#</a>
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

				<cfloop array="#partial.users#" index="user">

					<cfset mapper.append( [] ) />
					<cfset mapperRowIndex++ />
					<cfset mapperColumnIndex = 0 />

					<tr>
						<th scope="row">
							<p class="user-name">
								<a href="/index.cfm?event=playground.staging.user&userID=#encodeForUrl( user.id )#">#encodeForHtml( user.name )#</a>
							</p>
							<dl class="user-context">
								<div>
									<dt>key:</dt>
									<dd>#encodeForHtml( user.id )#</dd>
								</div>
								<div>
									<dt>user.id:</dt>
									<dd>#encodeForHtml( user.id )#</dd>
								</div>
								<div>
									<dt>user.email:</dt>
									<dd>#encodeForHtml( user.email )#</dd>
								</div>
								<div>
									<dt>user.role:</dt>
									<dd>#encodeForHtml( user.role )#</dd>
								</div>
								<div>
									<dt>user.company.id:</dt>
									<dd>#encodeForHtml( user.company.id )#</dd>
								</div>
								<div>
									<dt>user.company.subdomain:</dt>
									<dd>#encodeForHtml( user.company.subdomain )#</dd>
								</div>
								<div>
									<dt>user.company.fortune100:</dt>
									<dd>#encodeForHtml( user.company.fortune100 )#</dd>
								</div>
								<div>
									<dt>user.company.fortune500:</dt>
									<dd>#encodeForHtml( user.company.fortune500 )#</dd>
								</div>
								<div>
									<dt>user.groups.betaTester:</dt>
									<dd>#encodeForHtml( user.groups.betaTester )#</dd>
								</div>
								<div>
									<dt>user.groups.influencer:</dt>
									<dd>#encodeForHtml( user.groups.influencer )#</dd>
								</div>
							</dl>
						</th>
						<cfloop array="#partial.features#" item="feature">

							<cfset result = partial.results[ user.id ][ feature.key ] />

							<td
								data-user-id="#encodeForHtmlAttribute( user.id )#"
								data-feature-key="#encodeForHtmlAttribute( feature.key )#"
								align="center"
								valign="center"
								class="variant-#result.variantIndex#">

								<a
									href="/index.cfm?event=playground.staging.explain&userID=#encodeForUrl( user.id )#&featureKey=#encodeForUrl( feature.key )#&environmentKey=#encodeForUrl( environment.key )#&from=staging"
									class="explain">
									#encodeForHtml( serializeJson( result.variant ) )#
								</a>

							</td>

						</cfloop>
					</tr>

				</cfloop>

			</tbody>
			</table>

		</section>

		<div x-data="Mapper" class="mapper">
			<table>
			<cfloop array="#partial.users#" index="user">
				<tr>
					<cfloop array="#partial.features#" index="feature">

						<cfset result = partial.results[ user.id ][ feature.key ] />

						<td class="variant-#result.variantIndex#">
							<button
								data-user-id="#encodeForHtmlAttribute( user.id )#"
								data-feature-key="#encodeForHtmlAttribute( feature.key )#"
								@click="scrollToResult()"
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

		function Mapper() {

			return {
				stateNode: null,
				scrollToResult: scrollToResult
			};

			function scrollToResult() {

				var userID = this.$el.dataset.userId;
				var featureKey = this.$el.dataset.featureKey;
				var node = document.querySelector( `.state [data-user-id="${ userID }"][data-feature-key="${ featureKey }"]` );

				if ( this.stateNode ) {

					this.stateNode.classList.remove( "target" );

				}

				if ( this.stateNode = node ) {

					this.stateNode.classList.add( "target" );
					this.stateNode.scrollIntoView({
						behavior: "smooth",
						block: "center",
						inline: "center"
					});

				}

			}

		}

	</script>
</cfsavecontent>
