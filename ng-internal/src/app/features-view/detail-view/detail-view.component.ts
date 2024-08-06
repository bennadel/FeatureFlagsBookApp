
// Import vendor modules.
import { Component } from "@angular/core";
import { RouterOutlet } from "@angular/router";

// Import app modules.

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "features-detail-view",
	standalone: true,
	imports: [
		RouterOutlet
	],
	styleUrl: "./detail-view.component.less",
	templateUrl: "./detail-view.component.html"
})
export class DetailViewComponent {

}
