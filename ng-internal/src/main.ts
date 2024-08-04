
// Import vendor modules.
import { bootstrapApplication } from "@angular/platform-browser";

// Import app modules.
import { AppComponent } from "~/app/app.component";
import { appConfig } from "~/app/app.config";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

// Note: Angular used to encourage calling enableProdMode(). However, this usage is now
// discouraged as it is implicitly called when you run the compiler with "optimizations".

// Todo: Can I get rid of the environments folder?

bootstrapApplication( AppComponent, appConfig )
	.catch(
		( error ) => {

			console.group( "Application Bootstrapping Error" );
			console.error( error );
			console.groupEnd();

		}
	)
;
