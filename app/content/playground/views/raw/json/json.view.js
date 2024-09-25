
// 5b9454 <-- md5 -s "/app/content/playground/views/raw/json/json.view"

// Import module styles.
import "./json.view.less";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

window.m5b9454 = {
	PrettyPrint
};

function PrettyPrint() {

	this.$el.textContent = JSON.stringify(
		JSON.parse( this.$el.textContent ),
		null,
		4
	);

}
