
// Import vendor modules.
import { Component } from "@angular/core";
import { RouterLink } from "@angular/router";
import { RouterOutlet } from "@angular/router";

// Import app modules.
import { SvgSpriteComponent } from "./svg-sprite.component";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "app-root",
	standalone: true,
	imports: [
		RouterLink,
		RouterOutlet,
		SvgSpriteComponent
	],
	styleUrl: "./app.component.less",
	templateUrl: "./app.component.html"
})
export class AppComponent {

}
