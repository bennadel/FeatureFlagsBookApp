
// Import vendor modules.
import { Component } from "@angular/core";
import { inject } from "@angular/core";

// Import app modules.
import { Session } from "~/app/shared/services/session";
import { WindowTitle } from "~/app/shared/services/window-title";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "account-view",
	standalone: true,
	imports: [],
	styleUrl: "./account-view.component.less",
	templateUrl: "./account-view.component.html"
})
export class AccountViewComponent {

	private windowTitle = inject( WindowTitle );

	public session = inject( Session );

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "Account" );

	}

}
