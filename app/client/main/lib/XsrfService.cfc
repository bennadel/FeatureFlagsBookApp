component
	output = false
	hint = "I provide functionality around the XSRF cookies and request validation."
	{

	// Define properties for dependency-injection.
	property name="challengeName" ioc:skip;
	property name="config" ioc:type="config";
	property name="cookieName" ioc:skip;
	property name="requestMetadata" ioc:type="core.lib.RequestMetadata";

	/**
	* I initialize the XSRF cookies service.
	*/
	public void function $init() {

		variables.cookieName = "XSRF-TOKEN";
		variables.challengeName = "X-XSRF-TOKEN";

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I set a new XSRF cookie regardless of whether or not one already exists.
	*/
	public string function cycleCookie() {

		var token = buildToken();

		cookie[ cookieName ] = buildCookieSettings({
			value: token
		});

		return token;

	}


	/**
	* I ensure that the XSRF cookie exists. If it doesn't a new XSRF cookie is set.
	*/
	public string function ensureCookie() {

		if ( ! cookieExists() ) {

			return cycleCookie();

		}

		return getCookieValue();

	}


	/**
	* I return the XSRF token names used for the various mechanics.
	*/
	public struct function getTokenNames() {

		return {
			cookie: cookieName,
			challenge: challengeName
		};

	}


	/**
	* I test to make sure that the XSRF challenge value matches the XSRF cookie.
	*/
	public void function testRequest() {

		var cookieValue = getCookieValue();
		var challengeValue = getChallengeValue();

		if ( ! cookieValue.len() ) {

			throw(
				type = "App.Xsrf.MissingCookie",
				message = "The xsrf token cookie is missing or empty.",
				detail = "Expected cookie: [#cookieName#]."
			);

		}

		if ( ! challengeValue.len() ) {

			throw(
				type = "App.Xsrf.MissingChallenge",
				message = "The xsrf token challenge is missing or empty.",
				detail = "Expected field: [#challengeName#]."
			);

		}

		if ( compare( cookieValue, challengeValue ) ) {

			throw(
				type = "App.Xsrf.Mismatch",
				message = "The xsrf token challenge does not match the xsrf token cookie.",
				detail = "Cookie: [#cookieValue#], Header: [#challengeValue#]."
			);

		}

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I build the XSRF cookie configuration using the given property overrides.
	*/
	private struct function buildCookieSettings( required struct overrides ) {

		// Caution: [sameSite:"strict"] means that the cookie will only be sent when the
		// request originates from the same site. Since the goal of the XSRF token is to
		// prevent cross-site scripting attacks, this is exactly what we want.
		var settings = [
			name: cookieName,
			domain: config.site.cookieDomain,
			expires: "never",
			encodeValue: false,
			httpOnly: false, // AJAX requests need access to this cookie.
			secure: config.isLive, // I only have an SSL certificate in production.
			sameSite: "strict",
			preserveCase: true
		];

		// The "value" attribute is the only required override.
		settings.append( overrides );

		return settings;

	}


	/**
	* I generate a new, random XSRF token.
	*/
	private string function buildToken( numeric tokenLength = 32 ) {

		var characters = [];
		var inputs = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

		for ( var i = 1 ; i <= tokenLength ; i++ ) {

			characters.append(
				inputs[ randRange( 1, inputs.len(), "sha1prng" ) ]
			);

		}

		return characters.toList( "" );

	}


	/**
	* I determine if the XSRF cookie exists.
	*/
	private boolean function cookieExists() {

		return cookie.keyExists( cookieName );

	}


	/**
	* I get the current XSRF challenge value. Returns the empty string if none exists.
	*/
	private string function getChallengeValue() {

		if ( form.keyExists( challengeName ) ) {

			return form[ challengeName ];

		}

		return "";

	}


	/**
	* I get the current XSRF cookie. Returns the empty string if none exists.
	*/
	private string function getCookieValue() {

		return ( cookie[ cookieName ] ?: "" );

	}

}
