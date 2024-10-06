
// Slug: 2wod20

// Import module styles.
import "./form.view.less";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

window.m2wod20 = {
	FormController
};

function FormController() {

	if ( window.location.hash ) {

		document.querySelector( "input[ name = 'redirectTo' ]" )
			.value += window.location.hash
		;

	}

}
