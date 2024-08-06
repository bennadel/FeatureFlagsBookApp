
// Import vendor modules.
import { Component } from "@angular/core";
import { RouterLink } from "@angular/router";
import { RouterOutlet } from "@angular/router";

// Import app modules.

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "app-root",
	standalone: true,
	imports: [
		RouterLink,
		RouterOutlet
	],
	styleUrl: "./app.component.less",
	templateUrl: "./app.component.html"
})
export class AppComponent {

}
