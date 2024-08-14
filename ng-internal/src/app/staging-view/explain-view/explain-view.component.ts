
// Import vendor modules.
import { Component } from "@angular/core";
import { inject } from "@angular/core";

// Import app modules.
import { WindowTitle } from "~/app/shared/services/window-title";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "staging-explain-view",
	standalone: true,
	inputs: [
		"userID",
		"featureKey",
		"environmentKey"
	],
	imports: [],
	styleUrl: "./explain-view.component.less",
	templateUrl: "./explain-view.component.html"
})
export class ExplainViewComponent {

	private windowTitle:WindowTitle = inject( WindowTitle );

	public userID!:number;
	public featureKey!:string;
	public environmentKey!:string;

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "Explain" );

	}

}