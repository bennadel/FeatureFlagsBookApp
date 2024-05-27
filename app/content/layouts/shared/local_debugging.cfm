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

</cfscript>
<!--- ------------------------------------------------------------------------------ --->
<!--- ------------------------------------------------------------------------------ --->
<hr />
<!--- ------------------------------------------------------------------------------ --->
<!--- ------------------------------------------------------------------------------ --->
<style type="text/css">
	#local-debugging {
		border: 4px solid red ;
		margin: 20px 0px 20px 0px ;
		padding: 20px 20px 20px 20px ;
	}

	#local-debugging > *:first-child {
		margin-top: 0px ;
	}
	#local-debugging > *:last-child {
		margin-bottom: 0px ;
	}

	#local-debugging th,
	#local-debugging td {
		font-size: 18px ;
	}
</style>

<div id="local-debugging">

	<h2>
		Last Processed Error
	</h2>

	<cfdump var="#request.lastProcessedError#" />

</div>
