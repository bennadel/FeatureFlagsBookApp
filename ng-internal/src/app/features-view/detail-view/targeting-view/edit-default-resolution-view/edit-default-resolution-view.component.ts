
// Import vendor modules.
import { Component } from "@angular/core";
import { inject } from "@angular/core";
import { RouterLink } from "@angular/router";

// Import app modules.
import { WindowTitle } from "~/app/shared/services/window-title";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "targeting-edit-default-resolution-view",
	standalone: true,
	inputs: [
		"featureKey",
		"environmentKey"
	],
	imports: [
		RouterLink
	],
	styleUrl: "./edit-default-resolution-view.component.less",
	templateUrl: "./edit-default-resolution-view.component.html"
})
export class EditDefaultResolutionViewComponent {

	private windowTitle:WindowTitle = inject( WindowTitle );

	public featureKey!:string;
	public environmentKey!:string;

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "Default Resolution" );

	}

}
