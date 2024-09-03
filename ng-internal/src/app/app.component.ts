
// Import vendor modules.
import { Component } from "@angular/core";
import { RouterLink } from "@angular/router";
import { RouterLinkActive } from "@angular/router";
import { RouterOutlet } from "@angular/router";

// Import app modules.
import { SvgIconComponent } from "./shared/components/svg-icon/svg-icon.component";
import { SvgSpriteComponent } from "./shared/components/svg-icon/svg-sprite.component";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "app-root",
	standalone: true,
	imports: [
		RouterLink,
		RouterLinkActive,
		RouterOutlet,
		SvgIconComponent,
		SvgSpriteComponent
	],
	styleUrl: "./app.component.less",
	templateUrl: "./app.component.html"
})
export class AppComponent {

}
