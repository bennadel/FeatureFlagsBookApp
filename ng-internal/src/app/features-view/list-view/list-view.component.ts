
// Import vendor modules.
import { Component } from "@angular/core";
import { RouterLink } from "@angular/router";

// Import app modules.

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "features-list-view",
	standalone: true,
	imports: [
		RouterLink
	],
	styleUrl: "./list-view.component.less",
	templateUrl: "./list-view.component.html"
})
export class ListViewComponent {

}
