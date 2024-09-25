
// 7a3b63 <-- md5 -s "/app/content/playground/views/walkthrough/shared/raw.view"

// Import module styles.
import "./raw.view.less";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

window.m7a3b63 = {
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
