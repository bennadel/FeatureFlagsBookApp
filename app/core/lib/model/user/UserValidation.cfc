component
	output = false
	hint = "I provide validation methods for the user entity."
	{

	// Define properties for dependency-injection.
	property name="validationUtilities" ioc:type="core.lib.util.ValidationUtilities";

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
			email.find( "@featureflagsbook.com" ) ||
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


	/**
	* I throw a user not found error.
	* 
	* Caution: This method doesn't really belong here - it's only being used to throw
	* errors for demo users. But, since I don't really have a full data access layer, I'm
	* putting it in the closest meaningful place.
	*/
	public void function throwUserNotFoundError() {

		throw( type = "App.Model.User.NotFound" );

	}

}
