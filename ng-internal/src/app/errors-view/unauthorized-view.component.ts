
// Import vendor modules.
import { Component } from "@angular/core";
import { inject } from "@angular/core";

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

}
