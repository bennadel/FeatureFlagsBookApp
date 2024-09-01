
// Import vendor modules.
import { Routes } from "@angular/router";

// Import application modules.
import { NotFoundViewComponent } from "./not-found-view.component";
import { UnauthorizedViewComponent } from "./unauthorized-view.component";
import { XsrfViewComponent } from "./xsrf-view.component";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

export var routes: Routes = [
	{
		path: "not-found",
		pathMatch: "full",
		component: NotFoundViewComponent
	},
	{
		path: "unauthorized",
		pathMatch: "full",
		component: UnauthorizedViewComponent
	},
	{
		path: "xsrf",
		pathMatch: "full",
		component: XsrfViewComponent
	}
];

// Note: Angular will automatically unwrap the default export when lazy loading routes via
// the loadChildren() method.
export default routes;