component
	output = false
	hint = "I help detect memory leaks in ColdFusion components."
	{

	// Define properties for dependency-injection.
	property name="ioc" ioc:type="core.lib.Injector";
	property name="magicFunctionName" ioc:skip;
	property name="magicTokenName" ioc:skip;
	property name="utilities" ioc:type="core.lib.util.Utilities";

	/**
	* I initialize the memory leak detector.
	*/
	public void function $init() {

		variables.magicTokenName = "$$MemoryLeakDetector$$Version$$";
		variables.magicFunctionName = "$$MemoryLeakDetector$$Inspect$$";

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I scan the services in the Injector, looking for memory leaks.
	*/
	public void function inspect() {

		var version = createUuid();
		var queue = utilities.structValueArray( ioc.getAll() );

		// We're going to perform a breadth-first search of the components, starting with
		// the Injector services and then collecting any additional components we find
		// along the way.
		while ( queue.isDefined( 1 ) ) {

			var target = queue.shift();

			if ( ! utilities.isComponent( target ) ) {

				continue;

			}

			// If this target has already been inspected, skip it. However, since memory
			// leaks may develop over time based on the user's interaction, we need to
			// check the version number (of the current inspection). Only skip if we're
			// in the same inspection workflow and we're revisiting this component.
			// --
			// Note: In Adobe ColdFusion, CFC's don't have a .keyExists() member method.
			// As such, in this case, I have to use the built-in function.
			if ( structKeyExists( target, magicTokenName ) && ( target[ magicTokenName ] == version ) ) {

				continue;

			}

			// Make sure we don't come back to this target within the current inspection.
			target[ magicTokenName ] = version;

			var targetMetadata = getMetadata( target );
			var targetName = targetMetadata.name;
			var targetScope = getVariablesScope( target );
			var propertyIndex = utilities.indexBy( targetMetadata.properties, "name" );
			var functionIndex = utilities.indexBy( targetMetadata.functions, "name" );

			for ( var key in targetScope ) {

				// Skip the public scope - memory leaks only show up in the private scope.
				if ( key == "this" ) {

					continue;

				}

				// Skip hidden functions created by the CFThread tag.
				if ( key.reFindNoCase( "^_cffunccfthread" ) ) {

					continue;

				}

				// Treat top-level null values as suspicious.
				if ( ! targetScope.keyExists( key ) ) {

					logMessage( "Possible memory leak in [#targetName#]: [null]." );
					continue;

				}

				if (
					! propertyIndex.keyExists( key ) &&
					! functionIndex.keyExists( key )
					) {

					logMessage( "Possible memory leak in [#targetName#]: [#key#]." );

				}

				// If the value is, itself, a component, add it to the queue for
				// subsequent inspection.
				if ( utilities.isComponent( targetScope[ key ] ) ) {

					queue.append( targetScope[ key ] );

				}

			}

		}

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I return the variables scope in the current execution context.
	*/
	private any function dangerouslyAccessVariablesInCurrentContext() {

		// Caution: This method has been injected into a targeted component and is being
		// executed in the context of that targeted component.
		return variables;

	}


	/**
	* I return the variables scope for the given target.
	*/
	private struct function getVariablesScope( required any target ) {

		// Inject the spy method so that we'll be able to pierce the private scope of the
		// target and observe the internal state. It doesn't matter if we inject this
		// multiple times, we're the only consumers.
		target[ magicFunctionName ] = variables.dangerouslyAccessVariablesInCurrentContext;

		return invoke( target, magicFunctionName );

	}


	/**
	* I log the given message to the standard out (console).
	*/
	private void function logMessage( required string message ) {

		cfdump(
			var = message,
			output = "console"
		);

	}

}
