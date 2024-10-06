
// Slug: j3oyz3

// Import module styles.
import "./raw.view.less";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

window.mj3oyz3 = {
	FeatureJson,
	PrettyPrint
};

function FeatureJson() {

	var el = this.$el;

	return {
		isShowingJson: false,
		toggleJson: toggleJson
	};

	function toggleJson() {

		this.isShowingJson = ! this.isShowingJson;

		if ( this.isShowingJson ) {

			setTimeout(
				() => el.scrollIntoView({
					behavior: "smooth",
					block: "start"
				}),
				200
			);

		}

	}

}


function PrettyPrint() {

	this.$el.textContent = JSON.stringify(
		JSON.parse( this.$el.textContent ),
		null,
		4
	);

}
