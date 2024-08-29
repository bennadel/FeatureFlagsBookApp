
// Import vendor modules.
import { Component } from "@angular/core";
import { inject } from "@angular/core";
import { LocationStrategy } from "@angular/common";
import { Router } from "@angular/router";

// Import app modules.
import { WindowTitle } from "~/app/shared/services/window-title";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "unauthorized-view",
	standalone: true,
	styleUrl: "./unauthorized-view.component.less",
	templateUrl: "./unauthorized-view.component.html"
})
export class UnauthorizedViewComponent {

	private locationStrategy = inject( LocationStrategy );
	private router = inject( Router );
	private windowTitle = inject( WindowTitle );

	// ---
	// LIFE-CYCLE METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "Authentication Error" );

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I reload the browser to route the user back through the authentication workflow.
	*/
	public reload() {

		// Since this component can be routed-to directly, we don't actually want the user
		// to refresh the current URL if it will just bring them back to this component.
		// In such a case, we ant to refresh the pre-Hash part of the URL (since we're
		// using hash-based routing).
		if ( this.isErrorReflectedInPath() ) {

			window.location.href = ( window.location.pathname + window.location.search );

		} else {

			window.location.reload();

		}

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I determine if the current component routing is reflected in the URL; or, if the
	* component is being rendered as part of a skipLocationChange.
	*/
	private isErrorReflectedInPath() : boolean {

		return ( this.router.url === this.locationStrategy.path() );

	}

}
