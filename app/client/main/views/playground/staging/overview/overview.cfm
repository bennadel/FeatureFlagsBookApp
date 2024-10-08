<cfscript>

	demoUsers = request.ioc.get( "core.lib.demo.DemoUsers" );
	featureWorkflow = request.ioc.get( "core.lib.workflow.FeatureWorkflow" );
	utilities = request.ioc.get( "core.lib.util.Utilities" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	config = getConfig( request.user.email );
	features = getFeatures( config );
	users = getUsers( request.user.email );
	companies = getCompanies( users );
	title = "Staging Contexts";

	request.template.title = title;

	include "./overview.view.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I get the users grouped by company. The authenticated user's company (devteam) is
	* always first; and the rest of the companies are sorted alphabetically.
	*/
	private array function getCompanies( required array users ) {

		var companyIndex = {};

		for ( var user in users ) {

			if ( ! companyIndex.keyExists( user.company.subdomain ) ) {

				companyIndex[ user.company.subdomain ] = {
					subdomain: user.company.subdomain,
					users: []
				};

			}

			companyIndex[ user.company.subdomain ].users.append( user );

		}

		var companies = utilities
			.structValueArray( companyIndex )
			.sort(
				( a, b ) => {

					if ( a.subdomain == "devteam" ) {

						return -1;

					}

					if ( b.subdomain == "devteam" ) {

						return 1;

					}

					return compare( a.subdomain, b.subdomain );

				}
			)
		;

		return companies;

	}


	/**
	* I get the config data for the given authenticated user.
	*/
	private struct function getConfig( required string email ) {

		return featureWorkflow.getConfig( email );

	}


	/**
	* I get the features for the given config.
	*/
	private array function getFeatures( required struct config ) {

		return utilities.toFeaturesArray( config.features );

	}


	/**
	* I get the users for the given authenticated user.
	*/
	private array function getUsers( required string email ) {

		return demoUsers.getUsers( email );

	}

</cfscript>
