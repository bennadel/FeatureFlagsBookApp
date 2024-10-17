<cfscript>

	config = request.ioc.get( "config" );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	clientConfig = config.bugsnag.client;
	startConfig = [
		apiKey: clientConfig.apiKey,
		releaseStage: clientConfig.releaseStage
	];

	if ( ! isNull( request.user ) ) {

		startConfig.user = [
			email: request.user.email
		];

	}

	include "./bugsnag.view.cfm";

</cfscript>
