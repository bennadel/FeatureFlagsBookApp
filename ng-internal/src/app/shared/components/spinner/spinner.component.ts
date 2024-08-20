
// Import vendor modules.
import { Component } from "@angular/core";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "app-spinner",
	standalone: true,
	inputs: [
		"delay"
	],
	host: {
		"[class.no-delay]": "! delay"
	},
	imports: [],
	styleUrl: "./spinner.component.less",
	templateUrl: "./spinner.component.html"
})
export class SpinnerComponent {

	public delay: boolean = true;

}
