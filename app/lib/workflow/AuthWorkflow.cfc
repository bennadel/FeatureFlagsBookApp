component
	output = false
	hint = "I provide workflow methods pertaining to authentication."
	{

	// Define properties for dependency-injection.
	property name="logger" ioc:type="lib.Logger";
	property name="sessionCookies" ioc:type="lib.SessionCookies";
	property name="userValidation" ioc:type="lib.model.user.UserValidation";

	/**
	* I initialize the auth workflow.
	*/
	public void function $init() {

		// This will be shared across all unauthorized request access.
		variables.NULL_REQUEST_USER = [
			exists: false,
			username: "",
			dataFilename: ""
		];

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get the user associated with the current request (using the session cookie).
	*/
	public struct function getRequestUser() {

		// In this PLAYGROUND application, we don't really have session management because
		// we don't really have any data persistence. As such, we're going to use the
		// provided email address as the session token.
		var email = sessionCookies.getCookie()
			.trim()
		;

		if ( ! email.len() ) {

			return NULL_REQUEST_USER;

		}

		return [
			exists: true,
			email: email,
			dataFilename: buildDataFilename( email )
		];

	}


	/**
	* I authenticate the given user.
	*/
	public void function login( required string email ) {

		email = userValidation.testEmail( email );

		// In this PLAYGROUND application, we don't really have any login validation
		// because we don't really have any data persistence. As such, we're going to
		// allow any email address (with a good format) to be authenticated. This email
		// address will also be used to drive the JSON filename for the feature flag data.
		sessionCookies.setCookie( email );

		logger.info(
			"User authenticated.",
			{
				email: email
			}
		);

	}


	/**
	* I end the current user session.
	*/
	public void function logout() {

		sessionCookies.deleteCookie();

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I build the JSON data filename from the given user. Since we have no data
	* persistence in this application for storing arbitrary tokens, we must build the
	* filename based on the email. This isn't intended to be secure.
	*/
	private string function buildDataFilename( required string email ) {

		var stub = hash( email, "sha-256", "utf-8", 10 ).lcase();
		var filename = "#stub#.json";

		return filename;

	}

}
