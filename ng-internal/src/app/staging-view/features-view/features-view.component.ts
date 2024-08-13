
// Import vendor modules.
import { Component } from "@angular/core";
import { inject } from "@angular/core";

// Import app modules.
import { WindowTitle } from "~/app/shared/services/window-title";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "staging-features-view",
	standalone: true,
	inputs: [
		"environmentKey"
	],
	imports: [],
	styleUrl: "./features-view.component.less",
	templateUrl: "./features-view.component.html"
})
export class FeaturesViewComponent {

	private windowTitle:WindowTitle = inject( WindowTitle );

	public environmentKey!:string;

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "Features" );

	}

}
