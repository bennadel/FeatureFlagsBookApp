component
	output = false
	hint = "I define the application settings and event-handlers."
	{

	// Define the application.
	this.name = "AppFeatureFlagsBookCom";
	this.applicationTimeout = createTimeSpan( 7, 0, 0, 0 );
	this.sessionManagement = false;
	this.setClientCookies = false;

	// CAUTION: We use this directory value to both load configuration files and to setup
	// mappings. As such, let's define it as the first thing we do.
	this.wwwroot = getDirectoryFromPath( getCurrentTemplatePath() );
	this.config = getConfigSettings();

	// Define the per-application path mappings. This is used for component paths and
	// expandPath() resolution.
	this.mappings = {
		"/client": "#this.wwwroot#../client",
		"/content": "#this.wwwroot#../content",
		"/core": "#this.wwwroot#../core",
		"/data": "#this.wwwroot#data",
		"/wwwroot": this.wwwroot
	};

	// As a security best practice, we DO NOT WANT to search for unscoped variables in any
	// scope other than the core variables, local, and arguments scope. The CGI, FORM,
	// URL, COOKIE, etc. should only ever be referenced explicitly.
	this.searchImplicitScopes = false;
	// Make sure that every struct key-case matches its original defining context. This
	// way, we don't get any unexpected upper-casing of keys (a legacy behavior).
	this.serialization = {
		preserveCaseForStructKey: true,
		preserveCaseForQueryColumn: true
	};
	// Make sure that all arrays are passed by reference. Historically, arrays have been
	// passed by value, which has no place in a modern language.
	this.passArrayByReference = true;
	// Make sure form fields with the same name are aggregated as an array. Historically,
	// like-named field were aggregated as a comma-delimited list.
	this.sameFormFieldsAsArray = true;

	// Make sure that the request is being made over SSL (in production).
	ensureSecureHttpRequest();

	// ---
	// PUBLIC METHODS (Event Handlers).
	// ---

	/**
	* I get called once when the application is being bootstrapped.
	*
	* NOTE: This method is inherently single-threaded by the ColdFusion application
	* server. However, if this method is called as part of an explicit re-initialization,
	* then it will not be single-threaded and concurrent traffic needs to be considered.
	*/
	public void function onApplicationStart() {

		var ioc
			= application.ioc
				= new core.lib.Injector()
		;
		var config
			= this.config
				= application.config
					= ioc.provide( "config", getConfigSettings( useCachedConfig = false ) )
		;

		request.logger = ioc.get( "core.lib.Logger" );

		// This is used to cache-bust some of the static assets.
		ioc.provide( "staticAssetVersion", "2024.07.30.06.39" );

		// As the very last step in the initialization process, we want to flag that the
		// application has been fully bootstrapped. This way, we can test the state of the
		// application in the global onError() event handler.
		application.isBootstrapped = true;

	}


	/**
	* I get called once to initialize the request.
	*/
	public void function onRequestStart() {

		if ( url?.init == this.config.initPassword ) {

			this.onApplicationStart();

			// In the production app, redirect to the non-init page so that we don't run
			// the risk of re-initializing the application more often than we have to.
			if ( this.config.isLive ) {

				location( url = cgi.script_name, addToken = false );

			}

		}

		// Polyfill the Lucee CFML behavior in which "field[]" notation causes multiple
		// fields to be grouped together as an array.
		polyfillFormFieldGrouping( form );

		// By default, we want the request timeout to be relatively low so that we lock
		// page processing down. This means that we have to make a cognizant choice to
		// create slow(er) pages later on by explicitly extending the timeout.
		cfsetting(
			requestTimeout = 10,
			showDebugOutput = false
		);

		// Create a unified container for all of the data submitted by the user. This will
		// make it easier to access data when a workflow might deliver the data initially
		// in the URL scope and then subsequently in the FORM scope.
		request.context = structNew()
			.append( url )
			.append( form )
		;

		// Define the action variable. This will be a dot-delimited action string of what
		// to process.
		param name="request.context.event" type="string" default="";

		request.ioc = application.ioc;
		request.event = request.context.event.listToArray( "." );

	}


	/**
	* I handle uncaught errors within the application.
	*/
	public void function onError(
		required any exception,
		string eventName = ""
		) {

		// Override the request timeout so that we have time to handle any errors.
		cfsetting( requesttimeout = ( 60 * 5 ) );

		var error = ( exception.rootCause ?: exception.cause ?: exception );

		try {

			request.logger?.logException( error );

		} catch ( any loggingError ) {

			// If the logger aggregator hasn't been instantiated yet; or, if there was
			// error during logging, fallback to using ColdFusion's native console and
			// logging features.
			cfdump(
				var = loggingError,
				output = "console"
			);
			cflog(
				type = "fatal",
				log = "application",
				application = true,
				text = "#loggingError.type#: #loggingError.message#"
			);

		}

		// If the bootstrapping flag is null, it means that the application failed to
		// fully initialize. However, we can't be sure where in the process the error
		// occurred, so we want to just stop the application and let the next inbound
		// request re-trigger the application start-up.
		if ( isNull( application.isBootstrapped ) ) {

			cfheader( statusCode = 503, statusText = "Service Unavailable" );
			writeOutput( "<h1> Service Unavailable </h1>" );
			writeOutput( "<p> Please try back in a few minutes. </p>" );

			// If the application isn't actually running yet, attempting to stop it will
			// throw an error.
			try {

				applicationStop();

			} catch ( any stopError ) {

				// Swallow error, let next request start application.

			}

			return;

		}

		// Check to see if we are live or not. If we are live then we want to display
		// the user-friendly error page. However, if we're not live, then we want to
		// render the error for debugging.
		if ( ! this.config.isLive ) {

			// We are local, dump the error out for debugging.
			cfheader( statusCode = 500, statusText = "Server Error" );
			writeDump( var = exception, top = 5 );
			abort;

		}

		// Since we don't know where exactly the error occurred, it's possible that the
		// request has been flushed already or is in an entirely unusable state. As such,
		// the best we can do is just show a vanilla error message.
		writeOutput( "An error occurred." );
		abort;

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I make sure that the incoming request is being made over SSL. And, if not, it will
	* redirect the request to the HTTPS equivalent.
	*/
	private void function ensureSecureHttpRequest() {

		// For simplicity, I'm only using the ColdFusion server directly without a front-
		// facing web-server. As such, I only have http locally.
		if ( ! this.config.isLive ) {

			return;

		}

		if ( cgi.https == "on" ) {

			return;

		}

		var headers = getHttpRequestData( false ).headers;
		var proto = ( headers[ "X-Forwarded-Proto" ] ?: "" );

		if ( proto == "https" ) {

			return;

		}

		var secureUrl = ( cgi.query_string.len() )
			? "https://#cgi.server_name##cgi.script_name#?#cgi.query_string#"
			: "https://#cgi.server_name##cgi.script_name#"
		;

		location(
			url = secureUrl,
			addtoken = false,
			statuscode = 301
		);

	}


	/**
	* I return the application's environment-specific config object.
	*
	* CAUTION: The config object is cached in the SERVER scope using "this.name" as part
	* of the access key. It also uses "this.wwwroot" to locate the config object.
	*/
	private struct function getConfigSettings( boolean useCachedConfig = true ) {

		var configName = "appConfig_#this.name#";

		if ( useCachedConfig && server.keyExists( configName ) ) {

			return server[ configName ];

		}

		var config
			= server[ configName ]
				= deserializeJson( fileRead( "#this.wwwroot#../config/config.json" ) )
		;

		return config;

	}


	/**
	* I polyfill the "field[]" form parameter grouping behavior in Adobe ColdFusion.
	*/
	private void function polyfillFormFieldGrouping( required struct formScope ) {

		// If the fieldNames entry isn't defined, the form scope isn't populated.
		if ( ! formScope.keyExists( "fieldNames" ) ) {

			return;

		}

		// The parameter map gives us every form field as an array.
		var rawFormData = getPageContext()
			.getRequest()
			.getParameterMap()
		;

		for ( var key in rawFormData.keyArray() ) {

			if ( key.right( 2 ) == "[]" ) {

				// Remove the "[]" suffix.
				var normalizedKey = key.left( -2 );

				// The underlying Java value is of type, "string[]". We need to convert
				// that value to a native ColdFusion array (ArrayList) so that it will
				// behave like any other array, complete with member methods.
				var normalizedValue = arrayNew( 1 )
					.append( rawFormData[ key ], true )
				;

				// Swap the form scope key-value pairs with the normalized versions.
				formScope[ normalizedKey ] = normalizedValue;
				formScope.delete( key );

			}

		}

		// Clean-up list of field names (removing [] notation).
		formScope.fieldNames = formScope.fieldNames
			.reReplace( "\[\](,|$)", "\1", "all" )
		;

	}

}
