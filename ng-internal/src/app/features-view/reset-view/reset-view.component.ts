
// Import vendor modules.
import { Component } from "@angular/core";
import { inject } from "@angular/core";
import { RouterLink } from "@angular/router";

// Import app modules.
import { WindowTitle } from "~/app/shared/services/window-title";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "features-reset-view",
	standalone: true,
	imports: [
		RouterLink
	],
	styleUrl: "./reset-view.component.less",
	templateUrl: "./reset-view.component.html"
})
export class ResetViewComponent {

	private windowTitle = inject( WindowTitle );

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "Reset Demo Data" );

	}

}
