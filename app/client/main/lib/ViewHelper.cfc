component
	output = false
	hint = "I provide utility methods to make view rendering easier."
	{

	/**
	* I return the checked attribute based on the given condition.
	*/
	public string function attrChecked( required boolean input ) {

		if ( input ) {

			return "checked";

		}

		return "";

	}


	/**
	* I return a list of class names that map to truthy values in the given options.
	*/
	public string function attrClass( required struct options ) {

		var classNames = [];

		for ( var className in options ) {

			if ( ! options.keyExists( className ) ) {

				continue;

			}

			if ( isBoolean( options[ className ] ) ) {

				if ( options[ className ] ) {

					classNames.append( className );

				}

			} else if ( isSimpleValue( options[ className ] ) ) {

				if ( len( options[ className ] ) ) {

					classNames.append( className );

				}

			}

		}

		return ( 'class="#classNames.toList( " " )#"' );

	}


	/**
	* I return the selected attribute based on the given condition.
	*/
	public string function attrSelected( required boolean input ) {

		if ( input ) {

			return "selected";

		}

		return "";

	}

}
