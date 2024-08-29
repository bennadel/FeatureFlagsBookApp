
// Import vendor modules.
import { Component } from "@angular/core";
import { inject } from "@angular/core";

// Import app modules.
import { WindowTitle } from "~/app/shared/services/window-title";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "xsrf-view",
	standalone: true,
	styleUrl: "./xsrf-view.component.less",
	templateUrl: "./xsrf-view.component.html"
})
export class XsrfViewComponent {

	private windowTitle = inject( WindowTitle );

	// ---
	// LIFE-CYCLE METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "XSRF Error" );

	}

}
