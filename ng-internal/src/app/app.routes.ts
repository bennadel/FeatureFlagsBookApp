
// Import vendor modules.
import { Routes } from "@angular/router";

// Import app modules.
import AboutRoutes from "./about-view/about-view.routes";
import AccountRoutes from "./account-view/account-view.routes";
import ErrorsRoutes from "./errors-view/errors-view.routes";
import FeaturesRoutes from "./features-view/features-view.routes";
import RawRoutes from "./raw-view/raw-view.routes";
import StagingRoutes from "./staging-view/staging-view.routes";
import UsersRoutes from "./users-view/users-view.routes";

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
		children: AboutRoutes
		// loadChildren: () => import( "./about-view/about-view.routes" )
	},
	{
		path: "account",
		pathMatch: "prefix",
		children: AccountRoutes
		// loadChildren: () => import( "./account-view/account-view.routes" )
	},
	{
		path: "errors",
		pathMatch: "prefix",
		children: ErrorsRoutes
		// loadChildren: () => import( "./errors-view/errors-view.routes" )
	},
	{
		path: "features",
		pathMatch: "prefix",
		children: FeaturesRoutes
		// loadChildren: () => import( "./features-view/features-view.routes" )
	},
	{
		path: "raw",
		pathMatch: "prefix",
		children: RawRoutes
		// loadChildren: () => import( "./raw-view/raw-view.routes" )
	},
	{
		path: "staging",
		pathMatch: "prefix",
		children: StagingRoutes
		// loadChildren: () => import( "./staging-view/staging-view.routes" )
	},
	{
		path: "users",
		pathMatch: "prefix",
		children: UsersRoutes
		// loadChildren: () => import( "./users-view/users-view.routes" )
	},
	{
		path: "**",
		redirectTo: "/errors/not-found"
	}
];
