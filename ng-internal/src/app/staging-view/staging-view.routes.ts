
// Import vendor modules.
import { Routes } from "@angular/router";

// Import application modules.
import { createNumberResolver } from "~/app/shared/routing/resolvers";
import { EnvironmentsViewComponent } from "./environments-view/environments-view.component";
import { ExplainViewComponent } from "./explain-view/explain-view.component";
import { FeaturesViewComponent } from "./features-view/features-view.component";
import { UserViewComponent } from "./user-view/user-view.component";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

export var routes: Routes = [
	{
		path: "",
		pathMatch: "full",
		redirectTo: "environments"
	},
	{
		path: "environments",
		pathMatch: "full",
		component: EnvironmentsViewComponent
	},
	{
		path: "features/:environmentKey",
		pathMatch: "full",
		component: FeaturesViewComponent
	},
	{
		path: "users/:userID",
		pathMatch: "full",
		component: UserViewComponent,
		resolve: {
			userID: createNumberResolver( "userID" )
		}
	},
	{
		path: "users/:userID/explain/:featureKey/:environmentKey",
		pathMatch: "full",
		component: ExplainViewComponent,
		resolve: {
			userID: createNumberResolver( "userID" )
		}
	}
];

// Note: Angular will automatically unwrap the default export when lazy loading routes via
// the loadChildren() method.
export default routes;
