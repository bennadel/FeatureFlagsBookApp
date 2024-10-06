component
	output = false
	hint = "I provide the default logger implementation."
	{

	/**
	* I log the given error to the default log file.
	*/
	public void function logException(
		required any error,
		string message = ""
		) {

		writeLog(
			text = trim( "[#error.type#] #error.message# #message#" ),
			type = "error"
		);

	}

}
