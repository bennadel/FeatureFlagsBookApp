
// Import vendor modules.
import { Component } from "@angular/core";
import { inject } from "@angular/core";
import { RouterLink } from "@angular/router";

// Import app modules.
import { WindowTitle } from "~/app/shared/services/window-title";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "targeting-edit-rules-enabled-view",
	standalone: true,
	inputs: [
		"featureKey",
		"environmentKey"
	],
	imports: [
		RouterLink
	],
	styleUrl: "./edit-rules-enabled-view.component.less",
	templateUrl: "./edit-rules-enabled-view.component.html"
})
export class EditRulesEnabledViewComponent {

	private windowTitle = inject( WindowTitle );

	public featureKey!: string;
	public environmentKey!: string;

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "Rules Enabled" );

	}

}
