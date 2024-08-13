
// Import vendor modules.
import { Routes } from "@angular/router";

// Import application modules.
import { ClearViewComponent } from "./clear-view/clear-view.component";
import { DeleteViewComponent } from "./delete-view/delete-view.component";
import { DetailViewComponent } from "./detail-view.component";
import { ResetViewComponent } from "./reset-view/reset-view.component";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

export var routes: Routes = [
	{
		path: "",
		pathMatch: "full",
		redirectTo: "targeting"
	},
	{
		path: "",
		pathMatch: "prefix",
		component: DetailViewComponent,
		children: [
			{
				path: "clear",
				pathMatch: "full",
				component: ClearViewComponent
			},
			{
				path: "delete",
				pathMatch: "full",
				component: DeleteViewComponent
			},
			{
				path: "reset",
				pathMatch: "full",
				component: ResetViewComponent
			},
			{
				path: "targeting",
				pathMatch: "prefix",
				loadChildren: () => import( "./targeting-view/targeting-view.routes" )
			}
		]
	}
];

// Note: Angular will automatically unwrap the default export when lazy loading routes via
// the loadChildren() method.
export default routes;
