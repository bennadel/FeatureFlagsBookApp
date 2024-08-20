
// Common types for the application.

export interface User {
	id: number;
	name: string;
	email: string;
	role: string;
	company: {
		id: number;
		subdomain: string;
		fortune100: boolean;
		fortune500: boolean;
	};
	groups: {
		betaTester: boolean;
		influencer: boolean;
	};
};
