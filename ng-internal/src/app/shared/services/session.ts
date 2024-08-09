
// Import vendor modules.
import { Injectable } from "@angular/core";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

declare global {
	interface Window {
		authenticatedUser: WindowUser;
	}
}

export interface WindowUser {
	email: string;
}

@Injectable({
	providedIn: "root"
})
export class Session {

	public user:WindowUser = window.authenticatedUser;

}
