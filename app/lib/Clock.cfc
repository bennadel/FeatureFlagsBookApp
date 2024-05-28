component
	output = false
	hint = "I provide utility methods around date/time access."
	{

	/**
	* I return the current date/time in UTC.
	*/
	public date function utcNow() {

		return dateConvert( "local2utc", now() );

	}

}
