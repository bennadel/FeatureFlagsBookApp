<cfscript>

	demoUsers = request.ioc.get( "core.lib.demo.DemoUsers" );
	ui = request.ioc.get( "core.lib.util.ViewHelper" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="url.sortOn" type="string" default="user.id";

	users = getUsers( request.user.email );
	authUsers = getAuthUsers( request.user.email );
	groups = getGroups( users, url.sortOn );
	title = request.template.title = "Demo Users For Targeting";

	include "./list.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the users that are built to represent the authenticated user's team.
	*/
	private array function getAuthUsers( required string email ) {

		return demoUsers.buildAuthenticatedUsers( email );

	}


	/**
	* I get the users sorted into groups using the given facet.
	*/
	private array function getGroups(
		required array users,
		required string sortOn
		) {

		var operators = {
			"user.id": {
				getFacet: ( user ) => "all",
				getLabel: ( facet ) => "All users"
			},
			"user.email": {
				getFacet: ( user ) => user.emailDomain,
				getLabel: ( facet ) => "Email ending with: #facet#"
			},
			"user.role": {
				getFacet: ( user ) => user.role,
				getLabel: ( facet ) => "Role: #facet#"
			},
			"user.company.id": {
				getFacet: ( user ) => user.company.id,
				getLabel: ( facet ) => "Company ID: #facet#"
			},
			"user.company.subdomain": {
				getFacet: ( user ) => user.company.subdomain,
				getLabel: ( facet ) => "Company subdomain: #facet#"
			},
			"user.company.fortune100": {
				getFacet: ( user ) => user.company.fortune100,
				getLabel: ( facet ) => "Fortune 100: #facet#"
			},
			"user.company.fortune500": {
				getFacet: ( user ) => user.company.fortune500,
				getLabel: ( facet ) => "Fortune 500: #facet#"
			},
			"user.groups.betaTester": {
				getFacet: ( user ) => user.groups.betaTester,
				getLabel: ( facet ) => "Beta-tester: #facet#"
			},
			"user.groups.influencer": {
				getFacet: ( user ) => user.groups.influencer,
				getLabel: ( facet ) => "Influencer: #facet#"
			}
		};

		if ( ! operators.keyExists( sortOn ) ) {

			sortOn = "user.id";

		}

		var operator = operators[ sortOn ];
		var groupIndex = {};
		var groups = [];

		for ( var user in users ) {

			var facet = operator.getFacet( user );

			if ( ! groupIndex.keyExists( facet ) ) {

				groupIndex[ facet ] = {
					name: operator.getLabel( facet ),
					users: []
				};
				groups.append( groupIndex[ facet ] );

			}

			groupIndex[ facet ].users.append( user );

		}

		return groups;

	}


	/**
	* I get the users for the given authenticated user.
	*/
	private array function getUsers( required string email ) {

		var users = demoUsers.getUsers( email );

		// For sorting and rendering purposes, we want to break apart the email address.
		for ( var user in users ) {

			user.emailUser = user.email.listFirst( "@" );
			user.emailDomain = ( "@" & user.email.listRest( "@" ) );

		}

		return users;

	}

</cfscript>
