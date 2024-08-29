
// Import vendor modules.
import { ApplicationConfig } from "@angular/core";
import { ErrorHandler } from "@angular/core";
import { provideHttpClient } from "@angular/common/http";
import { provideRouter } from "@angular/router";
import { provideZoneChangeDetection } from "@angular/core";
import { withComponentInputBinding } from "@angular/router";
import { withHashLocation } from "@angular/router";
import { withRouterConfig } from "@angular/router";

// Import app modules.
import { BugsnagErrorHandler } from "./shared/services/bugsnag-error-handler";
import { routes } from "./app.routes";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

export var appConfig: ApplicationConfig = {
	providers: [
		provideZoneChangeDetection({
			eventCoalescing: true
		}),
		{
			provide: ErrorHandler,
			useClass: BugsnagErrorHandler
		},
		provideRouter(
			routes,
			withHashLocation(),
			withComponentInputBinding(),
			withRouterConfig({
				paramsInheritanceStrategy: "always"
			})
		),
		provideHttpClient()
	]
};
