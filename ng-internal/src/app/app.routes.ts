
// Import vendor modules.
import { Routes } from "@angular/router";

// Import app modules.

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

export var routes: Routes = [
	{
		path: "",
		pathMatch: "full",
		redirectTo: "features"
	},
	{
		path: "about",
		pathMatch: "prefix",
		loadChildren: () => import( "./about-view/about-view.routes" )
	},
	{
		path: "account",
		pathMatch: "prefix",
		loadChildren: () => import( "./account-view/account-view.routes" )
	},
	{
		path: "errors",
		pathMatch: "prefix",
		loadChildren: () => import( "./errors-view/errors-view.routes" )
	},
	{
		path: "features",
		pathMatch: "prefix",
		loadChildren: () => import( "./features-view/features-view.routes" )
	},
	{
		path: "raw",
		pathMatch: "prefix",
		loadChildren: () => import( "./raw-view/raw-view.routes" )
	},
	{
		path: "staging",
		pathMatch: "prefix",
		loadChildren: () => import( "./staging-view/staging-view.routes" )
	},
	{
		path: "users",
		pathMatch: "prefix",
		loadChildren: () => import( "./users-view/users-view.routes" )
	},

	// { path: '**', component: PageNotFoundComponent },  // Wildcard route for a 404 page
];
