
// Import vendor modules.
import { Component } from "@angular/core";
import { inject } from "@angular/core";

// Import app modules.
import { WindowTitle } from "~/app/shared/services/window-title";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "staging-user-view",
	standalone: true,
	inputs: [
		"userID"
	],
	imports: [],
	styleUrl: "./user-view.component.less",
	templateUrl: "./user-view.component.html"
})
export class UserViewComponent {

	private windowTitle:WindowTitle = inject( WindowTitle );

	public userID!:number;

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "User Detail" );

	}

}
