component
	output = false
	hint = "I provide validation methods for the user entity."
	{

	// Define properties for dependency-injection.
	property name="validationUtilities" ioc:type="lib.ValidationUtilities";

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I validate and return the normalized email value.
	*/
	public string function testEmail( required string email ) {

		email = email
			.trim()
			.lcase()
		;

		if ( ! email.len() ) {

			throw(
				type = "App.Model.User.Email.Empty",
				message = "Email is empty."
			);

		}

		if ( email.len() > 75 ) {

			throw(
				type = "App.Model.User.Email.TooLong",
				message = "Email is too long."
			);

		}

		if (
			email.find( "@example.com" ) ||
			email.find( "@test.com" )
			) {

			throw(
				type = "App.Model.User.Email.Example",
				message = "Email is an example address."
			);

		}

		if ( email.find( "+" ) ) {

			throw(
				type = "App.Model.User.Email.Plus",
				message = "Email is using plus-mechanics."
			);

		}

		if ( ! email.reFind( "^[^@]+@[^@.]+(\.[^@.]+)+$" ) ) {

			throw(
				type = "App.Model.User.Email.InvalidFormat",
				message = "Email is not in an expected format."
			);

		}

		if ( email != validationUtilities.canonicalizeInput( email ) ) {

			throw(
				type = "App.Model.User.Email.SuspiciousEncoding",
				message = "Email contains unexpected encodings."
			);

		}

		return email;

	}

}
