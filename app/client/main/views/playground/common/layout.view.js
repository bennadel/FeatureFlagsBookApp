
// Slug: 2f8ql7

// Import module styles.
import "./layout.view.less";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

window.m2f8ql7 = {
	AppShell
};

function AppShell() {

	return {
		focusMain: focusMain
	};

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I programmatically focus the main content area.
	*/
	function focusMain() {

		this.$refs.main.focus();
		this.$refs.main.scrollIntoView();

	}

}
