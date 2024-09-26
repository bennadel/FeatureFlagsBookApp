
// ae7a24 <-- md5 -s "/app/content/playground/layouts/default/default.view"

// Import module styles.
import "./default.view.less";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

window.mae7a24 = {
	AppShell
};

function AppShell() {

	return {
		focusMain: focusMain
	};

	/**
	* I programmatically focus the main content area.
	*/
	function focusMain() {

		this.$refs.main.focus();
		this.$refs.main.scrollIntoView();

	}

}
