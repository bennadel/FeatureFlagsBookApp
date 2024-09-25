
// e22b58 <-- md5 -s "/app/content/auth/views/login/form/form.view"

// Import module styles.
import "./form.view.less";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

window.me22b58 = {
	FormController
};

function FormController() {

	if ( window.location.hash ) {

		document.querySelector( "input[ name = 'redirectTo' ]" )
			.value += window.location.hash
		;

	}

}
