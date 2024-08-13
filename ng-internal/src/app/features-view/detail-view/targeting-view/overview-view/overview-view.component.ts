
// Import vendor modules.
import { Component } from "@angular/core";
import { inject } from "@angular/core";
import { RouterLink } from "@angular/router";

// Import app modules.
import { WindowTitle } from "~/app/shared/services/window-title";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "targeting-overview-view",
	standalone: true,
	inputs: [
		"featureKey"
	],
	imports: [
		RouterLink
	],
	styleUrl: "./overview-view.component.less",
	templateUrl: "./overview-view.component.html"
})
export class OverviewViewComponent {

	private windowTitle:WindowTitle = inject( WindowTitle );

	public featureKey!:string;

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
