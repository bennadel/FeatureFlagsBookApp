component
	output = false
	hint = "I provide utility methods to make view rendering easier."
	{

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
	* I return the USE element for the given SVG icon type.
	*/
	public string function useIcon( required string type ) {

		var icons = {
			"logo": "svg-sprite--logo",
			"feature-flags": "svg-sprite--legacy-streamline-regular--interface-essential--lists--list-bullets-1",
			"staging": "svg-sprite--legacy-streamline-regular--interface-essential--layouts--layout-module",
			"users": "svg-sprite--legacy-streamline-regular--users--geometric-full-body-multiple-users--multiple-users-1",
			"raw-json": "svg-sprite--legacy-streamline-regular--programming-apps-websites--coding-files--file-code-1",
			"account": "svg-sprite--legacy-streamline-regular--users--geometric-close-up-single-users-neutral--single-neutraleutral"
		};

		return '<use href="###icons[ type ]#"></use>';

	}

}
