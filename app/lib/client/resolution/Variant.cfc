component
	output = false
	hint = "I implement the variant resolution strategy."
	{

	/**
	* I return a variant using the variant resolution strategy.
	*/
	public any function getVariant(
		required string key,
		required any variants,
		required struct resolution
		) {

		return resolution.variant;

	}

}
