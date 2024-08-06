
// Import vendor modules.
import { Routes } from "@angular/router";

// Import application modules.
import { AddViewComponent } from "./add-view/add-view.component";
import { ClearViewComponent } from "./clear-view/clear-view.component";
import { ListViewComponent } from "./list-view/list-view.component";
import { ResetViewComponent } from "./reset-view/reset-view.component";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

export var routes: Routes = [
	{
		path: "",
		pathMatch: "full",
		redirectTo: "list"
	},
	{
		path: "add",
		pathMatch: "full",
		component: AddViewComponent
	},
	{
		path: "clear",
		pathMatch: "full",
		component: ClearViewComponent
	},
	{
		path: "list",
		pathMatch: "full",
		component: ListViewComponent
	},
	{
		path: "reset",
		pathMatch: "full",
		component: ResetViewComponent
	},
	{
		path: ":featureKey",
		pathMatch: "prefix",
		loadChildren: () => import( "./detail-view/detail-view.routes" )
	}
];

// Note: Angular will automatically unwrap the default export when lazy loading routes via
// the loadChildren() method.
export default routes;
