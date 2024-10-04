
// Slug: au14j6

// Import module styles.
import "./json.view.less";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

window.mau14j6 = {
	PrettyPrint
};

function PrettyPrint() {

	this.$el.textContent = JSON.stringify(
		JSON.parse( this.$el.textContent ),
		null,
		4
	);

}
