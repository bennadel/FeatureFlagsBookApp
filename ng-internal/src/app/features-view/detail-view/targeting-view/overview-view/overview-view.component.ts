
// Import vendor modules.
import { Component } from "@angular/core";
import { inject } from "@angular/core";

// Import app modules.
import { WindowTitle } from "~/app/shared/services/window-title";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "targeting-overview-view",
	standalone: true,
	imports: [],
	styleUrl: "./overview-view.component.less",
	templateUrl: "./overview-view.component.html"
})
export class OverviewViewComponent {

	private windowTitle:WindowTitle = inject( WindowTitle );

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "Feature Flag Targeting" );

	}

}
