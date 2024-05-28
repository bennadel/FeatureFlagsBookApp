component
	output = false
	hint = "I provide validation methods for the config entity."
	{

	/**
	* I validate and return the normalized config value.
	*/
	public struct function testConfig( required struct config ) {

		// TODO: Do actual validation and normalization of data structure.

		return config;

	}


	/**
	* I throw a version conflict error.
	*/
	public void function throwVersionConflictError() {

		throw(
			type = "App.Model.Config.Version.Conflict",
			message = "Submitted config data is expired."
		);

	}

}
