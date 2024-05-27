component
	output = false
	hint = "I provide low-level HTTP access to the Cloudflare Turnstile API."
	{

	// Define properties for dependency-injection.
	property name="config" ioc:get="config";
	property name="httpUtilities" ioc:type="lib.HttpUtilities";

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I verify the given Cloudflare Turnstile challenge token.
	*/
	public struct function siteVerify(
		required string token,
		required string ipAddress,
		numeric timeoutInSeconds = 5
		) {

		cfhttp(
			result = "local.httpResponse",
			method = "post",
			url = "https://challenges.cloudflare.com/turnstile/v0/siteverify",
			getAsBinary = "yes",
			timeout = timeoutInSeconds
			) {

			cfhttpparam(
				type = "formfield",
				name = "secret",
				value = config.turnstile.server.apiKey
			);
			cfhttpparam(
				type = "formfield",
				name = "response",
				value = token
			);
			cfhttpparam(
				type = "formfield",
				name = "remoteip",
				value = ipAddress
			);
		}

		var statusCode = httpUtilities.parseStatusCode( httpResponse );
		var fileContent = httpUtilities.getFileContentAsString( httpResponse );

		if ( ! statusCode.ok ) {

			throw(
				type = "Turnstile.ApiClient.ApiFailure",
				message = "Cloudflare Turnstile API error.",
				detail = "Returned with status code: #statusCode.original#",
				extendedInfo = fileContent
			);

		}

		try {

			// Example response:
			// {
			//   "success": true,
			//   "error-codes": [],
			//   "challenge_ts": "2022-10-06T00:07:23.274Z",
			//   "hostname": "example.com"
			// }
			return deserializeJson( fileContent );

		} catch ( any error ) {

			throw(
				type = "Turnstile.ApiClient.PayloadError",
				message = "Cloudflare Turnstile API response consumption error.",
				detail = "Returned with status code: #statusCode.original#",
				extendedInfo = fileContent
			);

		}

	}

}
