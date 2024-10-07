<cfscript>

	config = request.ioc.get( "config" );

	// Only show in the LOCAL DEVELOPMENT environment.
	if ( config.isLive ) {

		exit;

	}

	// Only show if there was an error processed in the current request.
	if ( ! request.keyExists( "lastProcessedError" ) ) {

		exit;

	}

	include "./localDebugging.view.cfm";

</cfscript>
