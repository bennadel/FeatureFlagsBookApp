
// Slug: kkey9a

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

window.mkkey9a = {
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
		rebalanceDistribution: rebalanceDistribution
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

	/**
	* If there are only 2 variants (the most common use-case), I ensure that they add up
	* to 100, adjusting the other allocation as needed. This way, the user only has to
	* adjust one field.
	*/
	function rebalanceDistribution( event ) {

		var allocations = form.elements[ "resolutionDistribution[]" ];

		if ( allocations.length !== 2 ) {

			return;

		}

		var target = event.currentTarget;
		var otherTarget = ( allocations[ 0 ] === target )
			? allocations[ 1 ]
			: allocations[ 0 ]
		;
		otherTarget.value = ( 100 - target.value );

	}

}
