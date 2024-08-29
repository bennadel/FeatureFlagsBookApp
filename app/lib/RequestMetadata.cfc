component
	output = false
	hint = "I provide utility methods for accessing metadata about the current request."
	{

	/**
	* I return the request event parts.
	*/
	public array function getEvent() {

		return ( request.event ?: [] );

	}


	/**
	* I return the fingerprint of the current client.
	*/
	public string function getFingerprint() {

		return lcase( hash( getIpAddress() & getUserAgent() ) );

	}


	/**
	* I return the HTTP headers.
	*/
	public struct function getHeaders( array exclude = [] ) {

		var headers = getHttpRequestData( false )
			.headers
			.copy()
		;

		for ( var key in exclude ) {

			headers.delete( key );

		}

		return headers;

	}


	/**
	* I return the HTTP host.
	*/
	public string function getHost() {

		return cgi.server_name;

	}


	/**
	* I return the URL to be used for an internal redirect.
	*/
	public string function getInternalUrl() {

		var resource = getResource();

		if ( cgi.query_string.len() ) {

			return ( resource & "?" & cgi.query_string );

		}

		return resource;

	}


	/**
	* I return the most trusted IP address reported for the current request.
	*/
	public string function getIpAddress() {

		var headers = getHeaders();

		// Try to get the IP address being injected by the Cloudflare CDN. This is the
		// most "trusted" value since it's not being provided by the user - it's the last
		// external IP address outside of the Cloudflare network.
		if ( isHeaderPopulated( headers, "CF-Connecting-IP" ) ) {

			var ipValue = headers[ "CF-Connecting-IP" ].trim().lcase();

		// If the Cloudflare-provided IP isn't available, fallback to any proxy IP. This
		// is a user-provided value and should be used with caution - it can be spoofed
		// with little effort.
		} else if ( isHeaderPopulated( headers, "X-Forwarded-For" ) ) {

			var ipValue = headers[ "X-Forwarded-For" ].listFirst().trim().lcase();

		// If we have nothing else, defer to the standard CGI variable.
		} else {

			var ipValue = cgi.remote_addr.trim().lcase();

		}

		// Check to make sure the IP address only has valid characters. Since this is
		// user-provided data (for all intents and purposes), we should validate it.
		if ( ipValue.reFind( "[^0-9a-f.:]" ) ) {

			throw(
				type = "InvalidIpAddressFormat",
				message = "The reported IP address is invalid.",
				detail = "IP address: #ipValue#"
			);

		}

		return ipValue;

	}


	/**
	* I return the HTTP method.
	*/
	public string function getMethod() {

		return cgi.request_method.ucase();

	}


	/**
	* I return the HTTP protocol.
	*/
	public string function getProtocol() {

		if ( cgi.https == "on" ) {

			return "https";

		}

		return "http";

	}


	/**
	* I return the HTTP referer.
	*/
	public string function getReferer() {

		return cgi.http_referer;

	}


	/**
	* I return the executing script and any extra path information.
	*/
	public string function getResource() {

		return ( cgi.script_name & cgi.path_info );

	}


	/**
	* I return the HTTP scheme.
	*/
	public string function getScheme() {

		return ( getProtocol() & "://" );

	}


	/**
	* I return the executing script.
	*/
	public string function getScriptName() {

		return cgi.script_name;

	}


	/**
	* I return the HTTP URL.
	*/
	public string function getUrl() {

		var resource = ( getScheme() & getHost() & getResource() );

		if ( cgi.query_string.len() ) {

			return ( resource & "?" & cgi.query_string );

		}

		return resource;

	}


	/**
	* I return the client's user-agent.
	*/
	public string function getUserAgent() {

		return cgi.http_user_agent;

	}


	/**
	* I perform very light-weight validation to make sure the given input starts with a
	* slash (ie, is not an external URL).
	*/
	public boolean function isInternalUrl( required string input ) {

		return ( input.left( 1 ) == "/" );

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I determine if the given header value is populated with a non-empty, SIMPLE value.
	*/
	private boolean function isHeaderPopulated(
		required struct headers,
		required string key
		) {

		return (
			headers.keyExists( key ) &&
			isSimpleValue( headers[ key ] ) &&
			headers[ key ].trim().len()
		);

	}

}
