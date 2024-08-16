
// Import vendor modules.
import { Component } from "@angular/core";
import { inject } from "@angular/core";
import { RouterLink } from "@angular/router";

// Import app modules.
import { WindowTitle } from "~/app/shared/services/window-title";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "detail-delete-view",
	standalone: true,
	inputs: [
		"featureKey"
	],
	imports: [
		RouterLink
	],
	styleUrl: "./delete-view.component.less",
	templateUrl: "./delete-view.component.html"
})
export class DeleteViewComponent {

	private windowTitle = inject( WindowTitle );

	public featureKey!: string;

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "Delete Feature Flag" );

	}

}
