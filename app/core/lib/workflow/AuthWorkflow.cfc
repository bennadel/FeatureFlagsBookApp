component
	output = false
	hint = "I provide workflow methods pertaining to authentication."
	{

	// Define properties for dependency-injection.
	property name="logger" ioc:type="core.lib.Logger";
	property name="sessionCookies" ioc:type="core.lib.SessionCookies";
	property name="userService" ioc:type="core.lib.model.user.UserService";

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I authenticate the given user.
	*/
	public void function login( required string email ) {

		// In this PLAYGROUND application, we don't really have any login validation
		// because we don't really have any data persistence. As such, we're going to
		// allow any email address (with a good format) to be authenticated. This email
		// address will also be used to drive the JSON filename for the feature flag data.
		var user = userService.getUser( email );

		sessionCookies.setCookie( user.email );
		logger.info( "User authenticated.", user );

	}


	/**
	* I end the current user session.
	*/
	public void function logout() {

		sessionCookies.deleteCookie();

	}


	/**
	* I return a Maybe result for the user associated with the current request (using the
	* session cookie).
	*/
	public struct function maybeGetRequestUser() {

		// In this PLAYGROUND application, we don't really have session management because
		// we don't really have any data persistence. As such, we're going to use the
		// provided email address as the session token.
		var email = sessionCookies.getCookie()
			.trim()
		;

		if ( ! email.len() ) {

			return {
				exists: false
			}

		}

		try {

			var user = userService.getUser( email );

			return {
				exists: true,
				value: user
			};

		} catch ( any error ) {

			// If the user couldn't be accessed by email, then the session token is
			// corrupted. Delete the session cookies so that the user will be returned to
			// a valid state (and can ten try to log back into the application).
			sessionCookies.deleteCookie();
			logger.logException( error, "Error getting user from session token." );

			return {
				exists: false
			}

		}

	}

}
