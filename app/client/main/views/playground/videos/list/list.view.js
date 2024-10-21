
// Slug: g7tzc2

// Import module styles.
import "./list.view.less";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

window.g7tzc2 = {
	VideoList
};

function VideoList() {

	var host = this.$el;

	return {
		init: init,
		updateFocus: updateFocus
	};

	// ---
	// LIFE-CYCLE METHODS.
	// ---

	/**
	* I initialize the component.
	*/
	function init() {

		this.updateFocus();

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I apply focus to the video that matches the hash.
	*/
	function updateFocus() {

		var fragment = window.location.hash.slice( 1 );

		if ( ! fragment ) {

			return;

		}

		var element = host.querySelector( `[id="${ fragment }"]` );

		if ( ! element ) {

			return;

		}

		element.focus();

	}

}
