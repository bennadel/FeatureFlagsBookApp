
// Import vendor modules.
import { Component } from "@angular/core";
import { inject } from "@angular/core";
import { RouterLink } from "@angular/router";
import { RouterOutlet } from "@angular/router";

// Import app modules.
import { FeatureStagingComponent } from "./feature-staging.component";
import { WindowTitle } from "~/app/shared/services/window-title";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "features-detail-view",
	standalone: true,
	inputs: [
		"featureKey"
	],
	imports: [
		FeatureStagingComponent,
		RouterLink,
		RouterOutlet
	],
	styleUrl: "./detail-view.component.less",
	templateUrl: "./detail-view.component.html"
})
export class DetailViewComponent {

	private windowTitle = inject( WindowTitle );

	public featureKey!: string;

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "Detail" );

	}

}
