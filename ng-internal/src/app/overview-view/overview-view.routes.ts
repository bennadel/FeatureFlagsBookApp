
// Import vendor modules.
import { Routes } from "@angular/router";

// Import application modules.
import { FeaturesViewComponent } from "./features-view/features-view.component";
import { UsersViewComponent } from "./users-view/users-view.component";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

export var routes: Routes = [
	{
		path: "",
		pathMatch: "full",
		redirectTo: "features"
	},
	{
		path: "features",
		pathMatch: "full",
		component: FeaturesViewComponent
	},
	{
		path: "users",
		pathMatch: "full",
		component: UsersViewComponent
	}
];

// Note: Angular will automatically unwrap the default export when lazy loading routes via
// the loadChildren() method.
export default routes;
