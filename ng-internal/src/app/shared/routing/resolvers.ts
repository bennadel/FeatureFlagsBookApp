
// Import vendor modules.
import { ResolveFn } from "@angular/router";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

/**
* I create a resolver function that casts the given route parameter to a number.
*/
export function createNumberResolver( paramName:string, fallbackValue:number = 0 ) : ResolveFn<number> {

	return ( routeSnapshot ) => {

		return ( +routeSnapshot.params[ paramName ] || fallbackValue );

	};

}
