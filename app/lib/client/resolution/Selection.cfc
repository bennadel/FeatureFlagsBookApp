component
	output = false
	hint = "I implement the selection resolution strategy."
	{

	/**
	* I return a variant using the selection resolution strategy.
	*/
	public any function getVariant(
		required string key,
		required any variants,
		required struct resolution
		) {

		return variants[ resolution.selection ];

	}

}
