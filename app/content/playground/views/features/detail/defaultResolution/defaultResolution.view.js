
// 9367e7 <-- md5 -s "/app/content/playground/views/features/detail/defaultResolution/defaultResolution.view"

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

window.m9367e7 = {
	FormController
};

function FormController() {

	var form = this.$el;

	// Return public API for proxy.
	return {
		init: $init,
		resolutionType: "",
		allocationTotal: 100,

		handleAllocation: handleAllocation,
		handleType: handleType,
	};

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I initialize the Alpine component.
	*/
	function $init() {

		this.handleType();
		this.handleAllocation();

	}

	/**
	* I update the allocation total after one of the distributions is changed.
	*/
	function handleAllocation() {

		this.allocationTotal = 0;

		for ( var element of form.elements[ "resolutionDistribution[]" ] ) {

			this.allocationTotal += parseInt( element.value, 10 );

		}

	}

	/**
	* I update the resolution details after the type is changed.
	*/
	function handleType( event ) {

		this.resolutionType = form.elements.resolutionType.value;

	}

}
