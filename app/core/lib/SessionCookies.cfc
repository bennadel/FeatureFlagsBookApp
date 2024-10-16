component
	output = false
	hint = "I provide methods for managing the session cookies for the current request."
	{

	// Define properties for dependency-injection.
	property name="config" ioc:type="config";
	property name="cookieName" ioc:skip;
	property name="logger" ioc:type="core.lib.Logger";

	/**
	* I initialize the session cookies service.
	*/
	public void function $init() {

		variables.cookieName = "ffb_playground";

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I delete / expire the current session cookies.
	*/
	public void function deleteCookie() {

		cookie[ cookieName ] = buildCookieSettings({
			value: "",
			expires: "now"
		});

	}


	/**
	* I get the current session cookies.
	*/
	public string function getCookie() {

		var hexEncoded = ( cookie[ cookieName ] ?: "" );

		if ( ! hexEncoded.len() ) {

			return "";

		}

		try {

			var bytes = binaryDecode( hexEncoded, "hex" );
			var sessionToken = charsetEncode( bytes, "utf-8" );

			// COLDFUSION BUG: It seems that ColdFusion won't throw an error if the hex-
			// decoding of the value fails - it will just return an empty byte array. Of
			// course, since we have a cookie value, we should end up with a valid session
			// token OR throw an error.
			if ( ! sessionToken.len() ) {

				throw(
					type = "BinaryDecodeError",
					message = "Could not decode HEX-encoded byte array."
				);

			}

			return sessionToken;

		} catch ( any error ) {

			if ( ! config.isLive ) {

				logger.logException( error, "Session cookie parsing error." );

			}

			// If there are any problems with the parsing, the cookie is corrupted (and
			// may have been tampered with). Just ignore this error (in production) and
			// delete the invalid cookie.
			deleteCookie();
			return "";

		}

	}


	/**
	* I get the current session cookies and then set the cookie to be expired. This is a
	* convenience method used during logouts.
	*/
	public string function getAndDeleteCookie() {

		var sessionToken = getCookie();
		deleteCookie();

		return sessionToken;

	}


	/**
	* I set / store the current session cookies.
	*/
	public void function setCookie( required string sessionToken ) {

		var bytes = charsetDecode( sessionToken, "utf-8" );
		var hexEncoded = binaryEncode( bytes, "hex" ).lcase();

		cookie[ cookieName ] = buildCookieSettings({
			value: hexEncoded,
			expires: "never"
		});

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I build the session cookie configuration using the given property overrides.
	*/
	private struct function buildCookieSettings( required struct overrides ) {

		// CAUTION: [sameSite:"strict"] means that the cookies will only be sent when the
		// request originates from the same site. Since this is just a playground with
		// very little in the way of authentication, we can safely beef-up cookie
		// restrictions. If we ever want to start sending out mail-based links, we'll have
		// to lower this to "lax" so that cross-NAVIGATION cookies will be included.
		var settings = [
			name: cookieName,
			domain: config.site.cookieDomain,
			encodeValue: false,
			httpOnly: true,
			secure: config.isLive, // I only have an SSL certificate in production.
			sameSite: "strict",
			preserveCase: true
		];

		// The "value" and "expires" attributes are expected to be overridden.
		settings.append( overrides );

		return settings;

	}

}
