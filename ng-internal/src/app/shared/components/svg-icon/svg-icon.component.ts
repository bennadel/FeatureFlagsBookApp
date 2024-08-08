
// Import vendor modules.
import { Component } from "@angular/core";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

var TYPE_MAPPINGS = {
	"logo":               "svg-sprite--logo",
	"nav-about":          "svg-sprite--legacy-streamline-regular--interface-essential--alerts--information-circleircle",
	"nav-account":        "svg-sprite--legacy-streamline-regular--users--geometric-close-up-single-users-neutral--single-neutraleutral",
	"nav-feature-flags":  "svg-sprite--legacy-streamline-regular--interface-essential--lists--list-bullets-1",
	"nav-raw":            "svg-sprite--legacy-streamline-regular--programming-apps-websites--coding-files--file-code-1",
	"nav-staging":        "svg-sprite--legacy-streamline-regular--interface-essential--layouts--layout-module",
	"nav-users":          "svg-sprite--legacy-streamline-regular--users--geometric-full-body-multiple-users--multiple-users-1",
};

type IconType = keyof typeof TYPE_MAPPINGS;

@Component({
	selector: "svg-icon",
	standalone: true,
	inputs: [
		"type"
	],
	host: {
		"aria-hidden": "true"
	},
	imports: [],
	styleUrl: "./svg-icon.component.less",
	templateUrl: "./svg-icon.component.html"
})
export class SvgIconComponent {

	public svgSpriteID = "";
	public type!:IconType;

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I handle changes to the input bindings.
	*/
	public ngOnChanges() {

		this.svgSpriteID = TYPE_MAPPINGS[ this.type ];

	}

}
