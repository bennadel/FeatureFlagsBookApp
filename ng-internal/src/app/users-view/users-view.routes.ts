
// Import vendor modules.
import { Routes } from "@angular/router";

// Import application modules.
import { UsersViewComponent } from "./users-view.component";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

export var routes: Routes = [
	{
		path: "",
		pathMatch: "full",
		component: UsersViewComponent
	}
];

// Note: Angular will automatically unwrap the default export when lazy loading routes via
// the loadChildren() method.
export default routes;
