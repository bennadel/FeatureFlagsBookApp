
// Common types for the application.

export namespace Demo {

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

	export interface Environment {
		key: string;
		name: string;
		description: string;
	};

	export type Feature =
		| AnyFeature
		| BooleanFeature
		| NumberFeature
		| StringFeature
	;

	interface BaseFeature {
		key: string;
		description: string;
		defaultSelection: number;
		targeting: TargetingMap;
	};

	export interface AnyFeature extends BaseFeature {
		type: "any";
		variants: any[];
	};

	export interface BooleanFeature extends BaseFeature {
		type: "boolean";
		variants: boolean[];
	};

	export interface NumberFeature extends BaseFeature {
		type: "number";
		variants: number[];
	};

	export interface StringFeature extends BaseFeature {
		type: "string";
		variants: string[];
	};

	export interface TargetingMap {
		[ environmentKey: string ]: Targeting;
	}

	export interface Targeting {
		resolution: Resolution;
		rulesEnabled: boolean;
		rules: Rule[];
	};

	export type Resolution =
		| SelectionResolution
		| DistributionResolution
		| VariantResolution
	;

	export interface SelectionResolution {
		type: "selection";
		selection: number;
	};

	export interface DistributionResolution {
		type: "distribution";
		distribution: number[];
	};

	export interface VariantResolution {
		type: "variant";
		variant: any;
	};

	export interface Rule {
		operator: string;
		input: string;
		values: SimpleValue[];
		resolution: Resolution;
	};

	export type SimpleValue = 
		| boolean
		| number
		| string
	;

};