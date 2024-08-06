
// Import vendor modules.
import { Routes } from "@angular/router";

// Import app modules.

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

export var routes: Routes = [
	{
		path: "",
		pathMatch: "full",
		redirectTo: "/overview/features"
	},
	{
		path: "features",
		pathMatch: "prefix",
		loadChildren: () => import( "./features-view/features-view.routes" )
	},
	{
		path: "overview",
		pathMatch: "prefix",
		loadChildren: () => import( "./overview-view/overview-view.routes" )
	},
	{
		path: "staging",
		pathMatch: "prefix",
		loadChildren: () => import( "./staging-view/staging-view.routes" )
	}

	// { path: '**', component: PageNotFoundComponent },  // Wildcard route for a 404 page
];
