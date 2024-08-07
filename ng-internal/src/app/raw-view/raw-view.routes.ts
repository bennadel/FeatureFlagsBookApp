
// Import vendor modules.
import { Routes } from "@angular/router";

// Import application modules.
import { RawViewComponent } from "./raw-view.component";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

export var routes: Routes = [
	{
		path: "",
		pathMatch: "full",
		component: RawViewComponent
	}
];

// Note: Angular will automatically unwrap the default export when lazy loading routes via
// the loadChildren() method.
export default routes;
