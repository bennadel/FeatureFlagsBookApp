
// Import vendor modules.
import { Component } from "@angular/core";
import { inject } from "@angular/core";
import { RouterLink } from "@angular/router";

// Import app modules.
import { WindowTitle } from "~/app/shared/services/window-title";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "not-found-view",
	standalone: true,
	imports: [
		RouterLink
	],
	styleUrl: "./not-found-view.component.less",
	templateUrl: "./not-found-view.component.html"
})
export class NotFoundViewComponent {

	private windowTitle = inject( WindowTitle );

	// ---
	// LIFE-CYCLE METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "Not Found" );

	}

}