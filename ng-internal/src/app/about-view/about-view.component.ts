
// Import vendor modules.
import { Component } from "@angular/core";
import { inject } from "@angular/core";

// Import app modules.
import { WindowTitle } from "~/app/shared/services/window-title";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "about-view",
	standalone: true,
	imports: [],
	styleUrl: "./about-view.component.less",
	templateUrl: "./about-view.component.html"
})
export class AboutViewComponent {

	private windowTitle = inject( WindowTitle );

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "About" );

	}

}
