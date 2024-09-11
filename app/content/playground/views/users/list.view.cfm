<cfsavecontent variable="request.template.primaryContent">
	<style type="text/css">

		.role-tag {
			border: 1px solid #cccccc ;
			border-radius: 4px ;
			display: inline-block ;
			padding: 2px 9px ;
		}

		.grid {
			border-collapse: collapse ;
			border-spacing: 0 ;
			width: 100% ;
		}
		.grid th,
		.grid td {
			border-bottom: 2px solid #cccccc ;
			padding: 7px 10px ;
			text-align: left ;
			white-space: nowrap ;
		}
		.grid th.sticky {
			background-color: #ffffff ;
			padding: 10px ;
			position: sticky ;
			top: -1px ;
			z-index: 2 ;
		}
		.grid .col-group {
			border: 1px dashed #cccccc ;
			border-bottom: 2px solid #cccccc ;
			padding: 10px ;
			text-align: center ;
		}
		.grid .row-group {
			padding: 20px 20px ;
			text-align: center ;
		}

		.grid tbody tr:hover th,
		.grid tbody tr:hover td {
			background-color: #f0f0f0 ;
		}
		.grid .sorter {
			cursor: pointer ;
			user-select: none ;
		}

		.diminish {
			opacity: 0.3 ;
		}
		.highlight {
			background-color: #fff59a ;
		}

	</style>
	<cfoutput>

		<section class="content-wrapper u-collapse-margin">

			<h1>
				#encodeForHtml( request.template.title )#
			</h1>

			<p>
				&larr; <a href="/index.cfm">Back to Overview</a>
			</p>

			<p>
				The following 100 users are used to demonstrate how feature flag targeting affects variant allocation. I've purposely used 100 so that every 1% of additional distribution will map (roughly) to 1 additional user.
			</p>

			<div x-data="AuthUsers">
				<p>
					I've also created <span x-text="authUsers.length"></span> users <mark>based on <em>your</em> email address</mark> that are part of a company with the subdomain "<strong>devteam</strong>":
				</p>
				<ul class="breathing-room">
					<template x-for="user in authUsers">
						<li>
							<span class="role-tag" x-text="user.role"></span>
							&rarr;
							<span x-text="user.email"></span>
						</li>
					</template>
				</ul>
			</div>

			<table x-data="Grid" id="grid" class="grid">
			<thead>
				<tr>
					<th colspan="3" class="col-group">
						User
					</th>
					<th colspan="4" class="col-group">
						Company
					</th>
					<th colspan="2" class="col-group">
						Groups
					</th>
				</tr>
				<tr>
					<!-- User. -->
					<th class="sticky">
						<a href="##grid" @click="sortOn( 'user.id' )" class="sorter">
							ID
						</a>
					</th>
					<th class="sticky">
						<a href="##grid" @click="sortOn( 'user.email' )" class="sorter">
							Email
						</a>
					</th>
					<th class="sticky">
						<a href="##grid" @click="sortOn( 'user.role' )" class="sorter">
							Role
						</a>
					</th>
					<!-- Company. -->
					<th class="sticky">
						<a href="##grid" @click="sortOn( 'user.company.id' )" class="sorter">
							ID
						</a>
					</th>
					<th class="sticky">
						<a href="##grid" @click="sortOn( 'user.company.subdomain' )" class="sorter">
							Subdomain
						</a>
					</th>
					<th class="sticky">
						<a href="##grid" @click="sortOn( 'user.company.fortune100' )" class="sorter">
							Fortune100
						</a>
					</th>
					<th class="sticky">
						<a href="##grid" @click="sortOn( 'user.company.fortune500' )" class="sorter">
							Fortune500
						</a>
					</th>
					<!-- Groups. -->
					<th class="sticky">
						<a href="##grid" @click="sortOn( 'user.groups.betaTester' )" class="sorter">
							BetaTester
						</a>
					</th>
					<th class="sticky">
						<a href="##grid" @click="sortOn( 'user.groups.influencer' )" class="sorter">
							Influencer
						</a>
					</th>
				</tr>
			</thead>
			<template x-for="( group, groupIndex ) in groups" :key="groupIndex">
				<tbody>
					<tr>
						<th colspan="9" class="row-group">
							<span x-text="group.name"></span>
							(<span x-text="group.users.length"></span>)
						</th>
					</tr>
					<template x-for="user in group.users" :key="user.id">
						<tr>
							<!-- User. -->
							<td
								:class="{ highlight: ( input === 'user.id' ) }"
								x-text="user.id">
							</td>
							<td :class="{ highlight: ( input === 'user.email' ) }">
								<span class="diminish" x-text="user.emailUser"></span><span x-text="user.emailDomain"></span>
							</td>
							<td
								:class="{ highlight: ( input === 'user.role' ) }"
								x-text="user.role">
							</td>
							<!-- Company. -->
							<td
								:class="{ highlight: ( input === 'user.company.id' ) }"
								x-text="user.company.id">
							</td>
							<td
								:class="{ highlight: ( input === 'user.company.subdomain' ) }"
								x-text="user.company.subdomain">
							</td>
							<td
								:class="{ highlight: ( input === 'user.company.fortune100' ) }"
								x-text="user.company.fortune100">
							</td>
							<td
								:class="{ highlight: ( input === 'user.company.fortune500' ) }"
								x-text="user.company.fortune500">
							</td>
							<!-- Groups. -->
							<td
								:class="{ highlight: ( input === 'user.groups.betaTester' ) }"
								x-text="user.groups.betaTester">
							</td>
							<td
								:class="{ highlight: ( input === 'user.groups.influencer' ) }"
								x-text="user.groups.influencer">
							</td>
						</tr>
					</template>
				</tbody>
			</template>
			</table>

		</section>

	</cfoutput>
	<script type="text/javascript">

		function AuthUsers() {

			var authUsers = JSON.parse( "<cfoutput>#encodeForJavaScript( serializeJson( demoUsers.buildAuthenticatedUsers( request.user.email ) ) )#</cfoutput>" );

			return {
				authUsers: authUsers
			}

		}

		function Grid() {

			var allUsers = JSON.parse( "<cfoutput>#encodeForJavaScript( serializeJson( demoUsers.getUsers( request.user.email ) ) )#</cfoutput>" );

			allUsers.forEach(
				( user ) => {

					var parts = user.email.split( "@" );
					user.emailUser = parts[ 0 ];
					user.emailDomain = `@${ parts[ 1 ] }`;

				}
			);

			return {
				input: null,
				groups: null,

				// Public methods.
				init: $init,
				sortOn: sortOn
			};

			// ---
			// PUBLIC METHODS.
			// ---

			function $init() {

				this.sortOn( "user.id" );

			}

			function sortOn( input ) {

				this.input = input;
				this.groups = [];

				var operators = {
					"user.id": {
						getFacet: ( user ) => "all",
						getLabel: ( facet ) => "All users"
					},
					"user.email": {
						getFacet: ( user ) => user.emailDomain,
						getLabel: ( facet ) => `Email ending with: ${ facet }`
					},
					"user.role": {
						getFacet: ( user ) => user.role,
						getLabel: ( facet ) => `Role: ${ facet }`
					},
					"user.company.id": {
						getFacet: ( user ) => user.company.id,
						getLabel: ( facet ) => `Company ID: ${ facet }`
					},
					"user.company.subdomain": {
						getFacet: ( user ) => user.company.subdomain,
						getLabel: ( facet ) => `Company subdomain: ${ facet }`
					},
					"user.company.fortune100": {
						getFacet: ( user ) => user.company.fortune100,
						getLabel: ( facet ) => `Fortune 100: ${ facet }`
					},
					"user.company.fortune500": {
						getFacet: ( user ) => user.company.fortune500,
						getLabel: ( facet ) => `Fortune 500: ${ facet }`
					},
					"user.groups.betaTester": {
						getFacet: ( user ) => user.groups.betaTester,
						getLabel: ( facet ) => `Beta tester: ${ facet }`
					},
					"user.groups.influencer": {
						getFacet: ( user ) => user.groups.influencer,
						getLabel: ( facet ) => `Influencer: ${ facet }`
					}
				};
				var operator = operators[ this.input ];
				var groupIndex = Object.create( null );

				for ( var user of allUsers ) {

					var facet = operator.getFacet( user );

					if ( ! groupIndex[ facet ] ) {

						groupIndex[ facet ] = {
							name: operator.getLabel( facet ),
							users: []
						};
						this.groups.push( groupIndex[ facet ] );

					}

					groupIndex[ facet ].users.push( user );

				}

			}

		}

	</script>
</cfsavecontent>
