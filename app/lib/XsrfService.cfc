component
	output = false
	hint = "I provide functionality around the XSRF cookies and request validation."
	{

	// Define properties for dependency-injection.
	property name="config" ioc:type="config";
	property name="requestMetadata" ioc:type="lib.RequestMetadata";

	/**
	* I initialize the XSRF cookies service.
	*/
	public void function $init() {

		variables.COOKIE_NAME = "XSRF-TOKEN";
		variables.HEADER_NAME = "X-XSRF-TOKEN";

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I set a new XSRF cookie regardless of whether or not one already exists.
	*/
	public string function cycleCookie() {

		var token = buildToken();

		cookie[ COOKIE_NAME ] = buildCookieSettings({
			value: token
		});

		return token;

	}


	/**
	* I ensure that the XSRF cookie exists. If it doesn't a new XSRF cookie is set.
	*/
	public void function ensureCookie() {

		if ( ! cookieExists() ) {

			cycleCookie();

		}

	}


	/**
	* I return the XSRF token names used for the various mechanics.
	* 
	* Todo: I might use this to explicitly define the Angular XSRF provider.
	*/
	public struct function getTokenNames() {

		return {
			cookie: COOKIE_NAME,
			header: HEADER_NAME
		};

	}


	/**
	* I test to make sure that the XSRF header matches the XSRF cookie.
	*/
	public void function testHeader() {

		var cookieValue = getCookie();
		var headerValue = getHeader();

		if ( ! cookieValue.len() ) {

			throw(
				type = "App.Xsrf.MissingCookie",
				message = "The xsrf token cookie is missing or empty.",
				detail = "Expected cookie: [#COOKIE_NAME#]."
			);

		}

		if ( ! headerValue.len() ) {

			throw(
				type = "App.Xsrf.MissingHeader",
				message = "The xsrf token header is missing or empty.",
				detail = "Expected header: [#HEADER_NAME#]."
			);

		}

		if ( compare( cookieValue, headerValue ) ) {

			throw(
				type = "App.Xsrf.Mismatch",
				message = "The xsrf token header does not match the xsrf token cookie.",
				detail = "Cookie: [#cookieValue#], Header: [#headerValue#]."
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
			name: COOKIE_NAME,
			domain: config.site.cookieDomain,
			expires: "never",
			encodeValue: false,
			httpOnly: false, // Angular needs access to this cookie.
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

		return cookie.keyExists( COOKIE_NAME );

	}


	/**
	* I get the current XSRF cookie. Returns the empty string if none exists.
	*/
	private string function getCookie() {

		return ( cookie[ COOKIE_NAME ] ?: "" );

	}


	/**
	* I get the current XSRF header. Returns the empty string if none exists.
	*/
	private string function getHeader() {

		var headers = requestMetadata.getHeaders();

		return ( headers[ HEADER_NAME ] ?: "" );

	}

}
