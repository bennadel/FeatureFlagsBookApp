
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

	public isHeaderExpanded = false;

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I handle mousing into the header.
	*/
	public handleHeaderMouseenter() {

		this.expandHeader();

	}

	/**
	* I handle mousing out of the header.
	*/
	public handleHeaderMouseleave() {

		this.collapseHeader();

	}

	/**
	* I handle clicking on a nav item.
	*/
	public handleLinkClick() {

		this.collapseHeader();

	}

	/**
	* I handle mousing into a nav item.
	*/
	public handleLinkMouseenter() {

		this.expandHeader();

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I collapse the header such that only the icons are visible.
	*/
	private collapseHeader() {

		this.isHeaderExpanded = false;

	}

	/**
	* I expand the header to show both the icons and the labels.
	*/
	private expandHeader() {

		this.isHeaderExpanded = true;

	}

}
