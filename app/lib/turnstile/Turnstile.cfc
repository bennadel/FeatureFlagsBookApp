component
	output = false
	hint = "I provide high-level HTTP access to the Cloudflare Turnstile API."
	{

	// Define properties for dependency-injection.
	property name="apiClient" ioc:type="lib.turnstile.TurnstileApiClient";

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I test the given Cloudflare Turnstile challenge token provided by the client-side
	* form. If the challenge passes successfully, the method exits. Otherwise, it throws
	* an error.
	*/
	public void function testToken(
		required string token,
		required string ipAddress
		) {

		if ( ! verifyToken( argumentCollection = arguments ) ) {

			throw(
				type = "App.Turnstile.VerificationFailure",
				message = "Cloudflare Turnstile verification failure.",
				detail = "Challenge did not pass, user might be a bot."
			);

		}

	}


	/**
	* I verify the given Cloudflare Turnstile challenge token. A True response indicates
	* that the client is likely a human.
	*/
	public boolean function verifyToken(
		required string token,
		required string ipAddress
		) {

		// If no token has been provided by the Turnstile system, then we know the user is
		// attempting to bypass the security. There's no need to make the API call.
		if ( ! token.len() ) {

			throw(
				type = "App.Turnstile.InvalidToken",
				message = "Cloudflare Turnstile token is empty."
			);

		}

		var apiResponse = apiClient.siteVerify( token, ipAddress );

		return apiResponse.success;

	}

}
