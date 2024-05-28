component
	output = false
	hint = "I provide service methods for the user entity."
	{

	// Define properties for dependency-injection.
	property name="validation" ioc:type="lib.model.user.UserValidation";

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get the user with the given email.
	*/
	public struct function getUser( required string email ) {

		// Normally, I wouldn't have to test the email address when getting the entity
		// from the database. However, since we don't actually have any data persistence
		// for users, and we're just returning a user object on-the-fly, let's make sure
		// the email is in the correct format.
		email = validation.testEmail( email );

		return {
			email: email,
			dataFilename: buildDataFilename( email )
		};

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I build the JSON data filename from the given email. Since we have no data
	* persistence in this application for storing arbitrary tokens, we must build the
	* filename based on the email. This isn't intended to be secure.
	*/
	private string function buildDataFilename( required string email ) {

		var stub = hash( email, "sha-256", "utf-8", 10 ).lcase();
		var filename = "#stub#.json";

		return filename;

	}

}
