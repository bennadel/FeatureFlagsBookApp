
// Import vendor modules.
import { Component } from "@angular/core";
import { inject } from "@angular/core";

// Import app modules.

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "feature-staging",
	standalone: true,
	inputs: [
		"featureKey"
	],
	imports: [],
	styleUrl: "./feature-staging.component.less",
	templateUrl: "./feature-staging.component.html"
})
export class FeatureStagingComponent {

	public featureKey!: string;

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {


	}

}
