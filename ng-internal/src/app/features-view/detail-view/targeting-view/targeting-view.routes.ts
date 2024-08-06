
// Import vendor modules.
import { Routes } from "@angular/router";

// Import application modules.
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
		path: "rules/:ruleIndex/delete",
		pathMatch: "full",
		component: DeleteRuleViewComponent
	},
	{
		path: "default-resolution",
		pathMatch: "full",
		component: EditDefaultResolutionViewComponent
	},
	{
		path: "rules/:ruleIndex",
		pathMatch: "full",
		component: EditRuleViewComponent
	},
	{
		path: "rules-enabled",
		pathMatch: "full",
		component: EditRulesEnabledViewComponent
	},
	{
		path: "overview",
		pathMatch: "full",
		component: OverviewViewComponent
	}
];

// Note: Angular will automatically unwrap the default export when lazy loading routes via
// the loadChildren() method.
export default routes;
