
// Import vendor modules.
import { ResolveFn } from "@angular/router";
import { Routes } from "@angular/router";

// Import application modules.
import { createNumberResolver } from "~/app/shared/routing/resolvers";
import { DeleteRuleViewComponent } from "./delete-rule-view/delete-rule-view.component";
import { EditDefaultResolutionViewComponent } from "./edit-default-resolution-view/edit-default-resolution-view.component";
import { EditRuleViewComponent } from "./edit-rule-view/edit-rule-view.component";
import { EditRulesEnabledViewComponent } from "./edit-rules-enabled-view/edit-rules-enabled-view.component";
import { OverviewViewComponent } from "./overview-view/overview-view.component";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

export var routes: Routes = [
	{
		path: "",
		pathMatch: "full",
		redirectTo: "overview"
	},
	{
		path: "overview",
		pathMatch: "full",
		component: OverviewViewComponent
	},
	{
		path: ":environmentKey",
		pathMatch: "prefix",
		children: [
			{
				path: "default-resolution",
				pathMatch: "full",
				component: EditDefaultResolutionViewComponent
			},
			{
				path: "rules/:ruleIndex/delete",
				pathMatch: "full",
				component: DeleteRuleViewComponent,
				resolve: {
					ruleIndex: createNumberResolver( "ruleIndex" )
				}
			},
			{
				path: "rules/:ruleIndex",
				pathMatch: "full",
				component: EditRuleViewComponent,
				resolve: {
					ruleIndex: createNumberResolver( "ruleIndex" )
				}
			},
			{
				path: "rules-enabled",
				pathMatch: "full",
				component: EditRulesEnabledViewComponent
			}
		]
	}
];

// Note: Angular will automatically unwrap the default export when lazy loading routes via
// the loadChildren() method.
export default routes;
