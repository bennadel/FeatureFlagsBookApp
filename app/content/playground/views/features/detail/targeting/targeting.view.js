
// Slug: n1883l

// Import module styles.
import "./targeting.view.less";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

window.mn1883l = {
	Editable,
	FlashRoot	
};

function FlashRoot() {

	var root = this.$el;
	var unflashTimer = null;
	var scrollTimer = null;

	return {
		flashDistal: flashDistal,
		flashProximal: flashProximal,
		unflash: unflash
	};

	/**
	* I highlight the associations, sourced from the distal trigger.
	*/
	function flashDistal( environmentKey, ruleIndex ) {

		clearTimeout( unflashTimer );
		clearTimeout( scrollTimer );

		root.dataset.flashSource = "distal";
		root.dataset.flashEnvironment = environmentKey;
		root.dataset.flashRule = ruleIndex;

		scrollTimer = setTimeout(
			() => {

				root
					.querySelector( `.flasher-proximal[data-flash-environment="${ environmentKey }"][data-flash-rule="${ ruleIndex }"]` )
					.scrollIntoView({
						behavior: "smooth",
						block: "center"
					})
				;

			},
			500
		);

	}

	/**
	* I highlight the associations, sourced from the proximal trigger.
	*/
	function flashProximal( environmentKey, ruleIndex = 0, ignoreEvent = false ) {

		if ( ignoreEvent ) {

			return;

		}

		clearTimeout( unflashTimer );
		clearTimeout( scrollTimer );

		root.dataset.flashSource = "proximal";
		root.dataset.flashEnvironment = environmentKey;
		root.dataset.flashRule = ruleIndex;

	}

	/**
	* I remove the association highlight.
	*/
	function unflash() {

		clearTimeout( unflashTimer );
		clearTimeout( scrollTimer );
		unflashTimer = setTimeout(
			() => {

				delete root.dataset.flashSource;
				delete root.dataset.flashEnvironment;
				delete root.dataset.flashRule;

			},
			250
		);

	}

}

function Editable() {

	return {
		handleClick: handleClick
	};

	// ---
	// PUBLIC METHODS.
	// ---

	function handleClick() {

		if ( ! this.$refs.edit.contains( this.$event.target ) ) {

			this.$refs.edit.click();

		}

	}

}
