
// Slug: rp1ra0

// Import module styles.
import "./rule.view.less";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

window.mrp1ra0 = {
	FormController
};

function FormController( values ) {

	var form = undefined;

	// Return public API for proxy.
	return {
		init: $init,
		values: values,
		datalist: "",

		// Public methods.
		handleAllocation: handleAllocation,
		handleInput: handleInput,
		handleOperator: handleOperator,
		handleType: handleType,
		handleValue: handleValue,
		removeValue: removeValue,

		// Private methods.
		_setDatalist: setDatalist
	};

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I initialize the Alpine component.
	*/
	function $init() {

		form = this.$el;

		this.handleInput()
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
	* I update the datalist in response to the input change.
	*/
	function handleInput() {

		this._setDatalist();

	}

	/**
	* I update the datalist in response to the operator change.
	*/
	function handleOperator() {

		this._setDatalist();

	}

	/**
	* I update the resolution details after the type is changed.
	*/
	function handleType( event ) {

		this.resolutionType = form.elements.resolutionType.value;

	}

	/**
	* I add a new value to the 
	*/
	function handleValue() {

		if ( ! this.$refs.rawValueRef.value ) {

			return;

		}

		this.values.push( this.$refs.rawValueRef.value );
		this.values.sort();
		this.$refs.rawValueRef.value = "";
		this.$refs.rawValueRef.focus();

	}

	/**
	* I remove the value at the given index.
	*/
	function removeValue( i ) {

		this.values.splice( i, 1 );

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I associate the correct datalist with the value input.
	*/
	function setDatalist() {

		var input = form.elements.input.value;
		var operator = form.elements.operator.value;

		// Special case for email-domain based targeting.
		if (
			( input === "user.email" ) &&
			( operator === "EndsWith" )
			) {

			this.datalist = "datalist.user.emailDomain";

		} else {

			this.datalist = `datalist.${ input }`;

		}

	}

}