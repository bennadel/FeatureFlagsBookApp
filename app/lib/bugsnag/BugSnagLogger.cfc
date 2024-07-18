component
	output = false
	hint = "I implement the logging interface and send data to the BugSnag API."
	{

	// Define properties for dependency-injection.
	property name="bugSnagApiClient" ioc:type="lib.bugsnag.BugSnagApiClient";
	property name="config" ioc:type="config";
	property name="requestMetadata" ioc:type="lib.RequestMetadata";

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I report the given item using a CRITICAL log-level.
	*/
	public void function critical(
		required string message,
		any data = {}
		) {

		logData( "Critical", message, data );

	}


	/**
	* I report the given item using a DEBUG log-level.
	*/
	public void function debug(
		required string message,
		any data = {}
		) {

		logData( "Debug", message, data );

	}


	/**
	* I report the given item using an ERROR log-level.
	*/
	public void function error(
		required string message,
		any data = {}
		) {

		logData( "Error", message, data );

	}


	/**
	* I report the given item using an INFO log-level.
	*/
	public void function info(
		required string message,
		any data = {}
		) {

		logData( "Info", message, data );

	}


	/**
	* I log the given data as a pseudo-exception (ie, we're shoehorning general log data
	* into a bug log tracking system since I don't have a logging system outside of error
	* tracking - gotta leverage those free tiers as much as I can).
	*/
	public void function logData(
		required string level,
		required string message,
		required any data = {}
		) {

		// NOTE: Normally, the errorClass represents an "error type". However, in this
		// case, since we don't have an error to log, we're going to use the message as
		// the grouping value. This makes sense since these are developer-provided
		// messages and will likely be unique in nature.
		sendToBugSnag({
			exceptions: [
				{
					errorClass: message,
					message: "#level# log entry",
					stacktrace: buildStacktraceForNonError(),
					type: "coldfusion"
				}
			],
			request: buildRequest(),
			context: buildContext(),
			severity: buildSeverity( level ),
			app: buildApp(),
			metaData: buildMetaData( data )
		});

	}


	/**
	* I report the given EXCEPTION object using an ERROR log-level.
	*/
	public void function logException(
		required any error,
		string message = "",
		any data = {}
		) {

		// Adobe ColdFusion doesn't treat the error like a Struct (when validating call
		// signatures). Let's make a shallow copy of the error so that we can use proper
		// typing in subsequent method calls.
		error = structCopy( error );

		sendToBugSnag({
			exceptions: [
				{
					errorClass: error.type,
					message: buildExceptionMessage( message, error ),
					stacktrace: buildStacktraceForError( error ),
					type: "coldfusion"
				}
			],
			request: buildRequest(),
			context: buildContext(),
			severity: buildSeverity( "error" ),
			app: buildApp(),
			metaData: buildMetaData( data, error )
		});

	}


	/**
	* I report the given item using a WARNING log-level.
	*/
	public void function warning(
		required string message,
		any data = {}
		) {

		logData( "Warning", message, data );

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I build the event app data.
	*/
	private struct function buildApp() {

		return {
			releaseStage: config.bugsnag.server.releaseStage
		};

	}


	/**
	* I build the event context data.
	*/
	private string function buildContext() {

		return requestMetadata.getEvent().toList( "." );

	}


	/**
	* I build the log message for the given exception.
	*/
	private string function buildExceptionMessage(
		required string message,
		required struct error
		) {

		if ( message.len() ) {

			return message;

		}

		return error.message;

	}


	/**
	* I build the event meta-data.
	*/
	private struct function buildMetaData(
		any data = {},
		struct error = {}
		) {

		var urlScope = url.copy();
		var formScope = form.copy();

		formScope.delete( "fieldnames" );

		return {
			urlScope: urlScope,
			formScope: formScope,
			data: data,
			error: error
		};

	}


	/**
	* I build the event request data.
	*/
	private struct function buildRequest() {

		return {
			clientIp: requestMetadata.getIpAddress(),
			headers: requestMetadata.getHeaders(
				exclude = [ "cookie" ]
			),
			httpMethod: requestMetadata.getMethod(),
			url: requestMetadata.getUrl(),
			referer: requestMetadata.getReferer()
		};

	}


	/**
	* I build the event severity data.
	*
	* NOTE: On the BugSnag side, the "level" information is a limited enum. As such, we
	* have to shoe-horn some of our internal level-usage into their finite set.
	*/
	private string function buildSeverity( required string level ) {

		switch ( level ) {
			case "fatal":
			case "critical":
			case "error":
				return "error";
			break;
			case "warning":
				return "warning";
			break;
			default:
				return "info";
			break;
		}

	}


	/**
	* I build the stacktrace for the given error.
	*/
	private array function buildStacktraceForError( required struct error ) {

		var tagContext = ( error.tagContext ?: [] );
		var stacktrace = tagContext
			.filter(
				( item ) => {

					return item.template.reFindNoCase( "\.(cfm|cfc)$" );

				}
			)
			.map(
				( item ) => {

					return {
						file: item.template,
						lineNumber: item.line
					};

				}
			)
		;

		return stacktrace;

	}


	/**
	* I build the stacktrace to be used for non-exception logging.
	*/
	private array function buildStacktraceForNonError() {

		var stacktrace = callstackGet()
			.filter(
				( item ) => {

					return ! item.template.findNoCase( "BugSnagLogger" );

				}
			)
			.map(
				( item ) => {

					return {
						file: item.template,
						lineNumber: item.lineNumber
					};

				}
			)
		;

		return stacktrace;

	}


	/**
	* I notify the BugSnag API about the given event using an async thread. Any errors
	* caught within the thread will be written to the error log.
	*/
	private void function sendToBugSnag( required struct notifyEvent ) {

		if ( ! config.isLive ) {

			sendToConsole( notifyEvent );
			return;

		}

		thread
			name = "BugSnagLogger.sendToBugSnag.#createUuid()#"
			notifyEvent = notifyEvent
			{

			try {

				bugSnagApiClient.notify([ notifyEvent ]);

			} catch ( any error ) {

				writeLog(
					type = "error",
					log = "Application",
					text = "[#error.type#]: #error.message#"
				);

				if ( ! config.isLive ) {

					sendToConsole( error );

				}

			}

		}

	}


	/**
	* I write the given data to the standard output (for local debugging).
	*/
	private void function sendToConsole( required any data ) {

		cfdump( var = data, output = "console" );

	}

}
