
// Import vendor modules.
import { Component } from "@angular/core";
import { inject } from "@angular/core";
import { RouterLink } from "@angular/router";

// Import app modules.
import { WindowTitle } from "~/app/shared/services/window-title";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "targeting-edit-rule-view",
	standalone: true,
	inputs: [
		"featureKey",
		"environmentKey",
		"ruleIndex"
	],
	imports: [
		RouterLink
	],
	styleUrl: "./edit-rule-view.component.less",
	templateUrl: "./edit-rule-view.component.html"
})
export class EditRuleViewComponent {

	private windowTitle:WindowTitle = inject( WindowTitle );

	public featureKey!:string;
	public environmentKey!:string;
	public ruleIndex!:number;

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "Edit Rule" );

	}

}
