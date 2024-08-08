
// Import vendor modules.
import { Component } from "@angular/core";
import { RouterLink } from "@angular/router";

// Import app modules.

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "staging-environments-view",
	standalone: true,
	imports: [
		RouterLink
	],
	styleUrl: "./environments-view.component.less",
	templateUrl: "./environments-view.component.html"
})
export class EnvironmentsViewComponent {

}
