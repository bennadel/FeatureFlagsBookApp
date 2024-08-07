
// Import vendor modules.
import { Routes } from "@angular/router";

// Import application modules.
import { AccountViewComponent } from "./account-view.component";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

export var routes: Routes = [
	{
		path: "",
		pathMatch: "full",
		component: AccountViewComponent
	}
];

// Note: Angular will automatically unwrap the default export when lazy loading routes via
// the loadChildren() method.
export default routes;
