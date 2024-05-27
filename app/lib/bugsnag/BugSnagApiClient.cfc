component
	output = false
	hint = "I report server-side errors to the BugSnag API."
	{

	// Define properties for dependency-injection.
	property name="apiKey" ioc:get="config.bugsnag.server.apiKey";
	property name="httpUtilities" ioc:type="lib.HttpUtilities";
	property name="releaseStage" ioc:get="config.bugsnag.server.releaseStage";

	/**
	* I initialize the BugSnag API client.
	*/
	public void function $init() {

		variables.payloadVersion = 5;
		variables.notifier = {
			name: "BugSnag ColdFusion (Custom)",
			version: "1.0.0",
			url: "https://app.featureflagsbook.com/"
		};
		variables.app = {
			version: dateTimeFormat( now(), "iso" ),
			releaseStage: releaseStage
		};

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I notify the BugSnag API about the given events.
	*/
	public void function notify(
		required array events,
		numeric timeoutInSeconds = 5
		) {

		cfhttp(
			result = "local.httpResponse",
			method = "post",
			url = "https://notify.bugsnag.com/",
			getAsBinary = "yes",
			timeout = timeoutInSeconds
			) {

			cfhttpParam(
				type = "header",
				name = "Bugsnag-Api-Key",
				value = apiKey
			);
			cfhttpParam(
				type = "header",
				name = "Bugsnag-Payload-Version",
				value = payloadVersion
			);
			cfhttpParam(
				type = "header",
				name = "Bugsnag-Sent-At",
				value = now().dateTimeFormat( "iso" )
			);
			cfhttpParam(
				type = "header",
				name = "Content-Type",
				value = "application/json"
			);
			cfhttpParam(
				type = "body",
				value = serializeJson({
					apiKey: apiKey,
					payloadVersion: payloadVersion,
					notifier: notifier,
					events: events,
					app: app
				})
			);
		}

		var statusCode = httpUtilities.parseStatusCode( httpResponse );

		if ( ! statusCode.ok ) {

			throw(
				type = "BugSnag.ApiClient.ApiFailure",
				message = "BugSnag notify API failure.",
				detail = "Returned with status code: #statusCode.original#",
				extendedInfo = httpUtilities.getFileContentAsString( httpResponse )
			);

		}

	}

}
