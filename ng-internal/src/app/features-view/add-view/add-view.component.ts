
// Import vendor modules.
import { Component } from "@angular/core";
import { inject } from "@angular/core";

// Import app modules.
import { WindowTitle } from "~/app/shared/services/window-title";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "features-add-view",
	standalone: true,
	imports: [],
	styleUrl: "./add-view.component.less",
	templateUrl: "./add-view.component.html"
})
export class AddViewComponent {

	private windowTitle:WindowTitle = inject( WindowTitle );

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "Add Feature Flag" );

	}

}
