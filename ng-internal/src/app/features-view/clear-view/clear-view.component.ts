
// Import vendor modules.
import { Component } from "@angular/core";
import { inject } from "@angular/core";
import { RouterLink } from "@angular/router";

// Import app modules.
import { WindowTitle } from "~/app/shared/services/window-title";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "features-clear-view",
	standalone: true,
	imports: [
		RouterLink
	],
	styleUrl: "./clear-view.component.less",
	templateUrl: "./clear-view.component.html"
})
export class ClearViewComponent {

	private windowTitle = inject( WindowTitle );

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "Clear All Targeting" );

	}

}
