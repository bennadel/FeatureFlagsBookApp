component
	output = false
	hint = "I provide logging methods for errors and arbitrary data."
	{

	// Define properties for dependency-injection.
	property name="bugSnagLogger" ioc:type="core.lib.bugsnag.BugSnagLogger";

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

		bugSnagLogger.critical( argumentCollection = arguments );

	}


	/**
	* I report the given item using a DEBUG log-level.
	*/
	public void function debug(
		required string message,
		any data = {}
		) {

		bugSnagLogger.debug( argumentCollection = arguments );

	}


	/**
	* I report the given item using an ERROR log-level.
	*/
	public void function error(
		required string message,
		any data = {}
		) {

		bugSnagLogger.error( argumentCollection = arguments );

	}


	/**
	* I report the given item using an INFO log-level.
	*/
	public void function info(
		required string message,
		any data = {}
		) {

		bugSnagLogger.info( argumentCollection = arguments );

	}


	/**
	* I log the given data as a pseudo-exception (ie, we're shoehorning general log data
	* into a bug log tracking system).
	*/
	public void function logData(
		required string level,
		required string message,
		required any data = {}
		) {

		bugSnagLogger.logData( argumentCollection = arguments );

	}


	/**
	* I report the given EXCEPTION object using an ERROR log-level.
	*/
	public void function logException(
		required any error,
		string message = "",
		any data = {}
		) {

		switch ( error.type ) {
			// The following errors are high-volume and don't represent much value. Let's
			// ignore these for now (since they aren't something that I can act upon).
			case "Nope":
			case "TurnstileClient.InvalidToken":
				// Swallow error for now.
			break;
			default:
				bugSnagLogger.logException( argumentCollection = arguments );
			break;
		}

	}


	/**
	* I report the given item using a WARNING log-level.
	*/
	public void function warning(
		required string message,
		any data = {}
		) {

		bugSnagLogger.warning( argumentCollection = arguments );

	}

}
