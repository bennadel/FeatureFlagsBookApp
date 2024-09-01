
// Import vendor modules.
import { Component } from "@angular/core";
import { FormsModule } from "@angular/forms";
import { inject } from "@angular/core";
import { Router } from "@angular/router";
import { RouterLink } from "@angular/router";

// Import app modules.
import { ApiClient } from "~/app/shared/services/api-client";
import { ErrorService } from "~/app/shared/services/error.service";
import { WindowTitle } from "~/app/shared/services/window-title";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

@Component({
	selector: "features-reset-view",
	standalone: true,
	imports: [
		FormsModule,
		RouterLink
	],
	styleUrl: "./reset-view.component.less",
	templateUrl: "./reset-view.component.html"
})
export class ResetViewComponent {

	private apiClient = inject( ApiClient );
	private errorService = inject( ErrorService );
	private router = inject( Router );
	private windowTitle = inject( WindowTitle );

	public errorMessage = "";

	// ---
	// LIFE-CYCLE METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "Reset Feature Tageting" );

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I process the form submission.
	*/
	public async processForm() {

		try {

			await this.apiClient.post({
				url: "/index.cfm?event=api.features.reset"
			});

			this.router.navigateByUrl( "/features" );

		} catch ( error ) {

			if ( ! this.errorService.handleError( error ) ) {

				this.errorMessage = this.errorService.getMessage( error );

			}

		}

	}

}
