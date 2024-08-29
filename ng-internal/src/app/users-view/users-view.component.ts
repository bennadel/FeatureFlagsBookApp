
// Import vendor modules.
import { ActivatedRoute } from "@angular/router";
import { Component } from "@angular/core";
import { DestroyRef } from "@angular/core";
import { inject } from "@angular/core";
import { ResolveData } from "@angular/router";
import { RouterLink } from "@angular/router";
import { SimpleChanges } from "@angular/core";

// Import app modules.
import { ApiClient } from "~/app/shared/services/api-client";
import { ErrorService } from "~/app/shared/services/error.service";
import { ExpiredResponseError } from "~/app/shared/errors";
import { SpinnerComponent } from "~/app/shared/components/spinner/spinner.component";
import { User } from "~/app/shared/types";
import { WindowTitle } from "~/app/shared/services/window-title";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

interface RouteInputs {
	sortOn: string;
};

interface Partial {
	users: User[];
	authenticatedUsers: User[];
};

interface EnhancedUser extends User {
	emailUser: string;
	emailDomain: string;
};

interface Group {
	name: string;
	users: EnhancedUser[];
};

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

var CACHED_RESPONSE: Partial | null = null;
var LAST_RESPONSE_ID = 0;

@Component({
	selector: "users-view",
	standalone: true,
	imports: [
		RouterLink,
		SpinnerComponent
	],
	styleUrl: "./users-view.component.less",
	templateUrl: "./users-view.component.html"
})
export class UsersViewComponent {

	private activatedRoute = inject( ActivatedRoute );
	private apiClient = inject( ApiClient );
	private destroyRef = inject( DestroyRef );
	private errorService = inject( ErrorService );
	private windowTitle = inject( WindowTitle );

	public routeInputs: RouteInputs = {
		sortOn: ""
	};
	public isLoading = true;
	public users: User[] = [];
	public authenticatedUsers: User[] = [];
	public enhancedUsers: EnhancedUser[] = [];
	public groups: Group[] = [];

	// ---
	// LIFE-CYCLE METHODS.
	// ---

	/**
	* I get called once after the component inputs have been bound for the first time.
	*/
	public ngOnInit() {

		this.windowTitle.set( "Demo Users" );

		this.activatedRoute.params.subscribe( this.handleActivatedRouteChange );
		this.loadRemoteData();

		// When the component is destroyed, we want to change the last response ID so that
		// any pending data load will be ignored.
		this.destroyRef.onDestroy( () => LAST_RESPONSE_ID++ );

	}

	public ngOnDestroy() {

		console.warn( "Users view desetruction." );

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I scroll the current view to the top.
	*/
	public scrollToTop() {

		var fragment = this.activatedRoute.snapshot.fragment;
		var selector = ( fragment )
			? `#${ fragment }`
			: "h1"
		;

		document.querySelector( selector )?.scrollIntoView({
			behavior: "instant",
			block: "start"
		});

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I gather all of the relevant URL-provided data, using sane defaults if no relevant
	* value is present in the URL.
	*/
	private getRouteInputs() : RouteInputs {

		var snapshot = this.activatedRoute.snapshot;

		return {
			sortOn: ( snapshot.params.sortOn || "user.id" )
		};

	}


	/**
	* I handle changes to the activated route, updating the view-model as necessary.
	*/
	private handleActivatedRouteChange = () => {

		var currentInputs = this.getRouteInputs();

		if ( this.isLoading ) {

			this.routeInputs = currentInputs;
			return;

		}

		if ( this.routeInputs.sortOn !== currentInputs.sortOn ) {

			this.routeInputs.sortOn = currentInputs.sortOn;
			this.setGroups();

		}

		this.scrollToTop();

	}


	/**
	* I load the primary payload for the current view.
	*/
	private async loadRemoteData() : Promise<void> {

		try {

			this.isLoading = true;
			await this.loadRemoteDataInBackground();

		} catch ( error ) {

			if ( ! this.errorService.handleError( error ) ) {

				console.group( "Users View Load Remote Data Error" );
				console.error( error );
				console.groupEnd();

			}

		}

	}


	/**
	* I quietly load the primary payload for the current view in the background.
	*/
	private async loadRemoteDataInBackground( useCache = true ) : Promise<void> {

		if ( useCache && CACHED_RESPONSE ) {

			this.isLoading = false;
			this.users = CACHED_RESPONSE.users;
			this.authenticatedUsers = CACHED_RESPONSE.authenticatedUsers;

			this.setEnhancedUsers();
			this.setGroups();

		}

		var responseID = ++LAST_RESPONSE_ID;
		var response = await this.apiClient.get<Partial>({
			url: "/index.cfm?event=api.partials.ngInternal.users"
		});

		if ( responseID !== LAST_RESPONSE_ID ) {

			throw( new ExpiredResponseError( "DemoUsers" ) );

		}

		CACHED_RESPONSE = response;

		this.isLoading = false;
		this.users = CACHED_RESPONSE.users;
		this.authenticatedUsers = CACHED_RESPONSE.authenticatedUsers;

		this.setEnhancedUsers();
		this.setGroups();

	}


	/**
	* I set the enhanced users based on the current view-model.
	*/
	private setEnhancedUsers() : void {

		this.enhancedUsers = this.users.map(
			( user ) => {

				var emailParts = user.email.split( "@" );
				var emailUser = emailParts[ 0 ];
				var emailDomain = `@${ emailParts[ 1 ] }`;

				return {
					...user,
					emailUser,
					emailDomain
				};

			}
		);

	}


	/**
	* I set the groups based on the current view-model.
	*/
	private setGroups() : void {

		// When we sort the users, we break the full user collection up into groups. Each
		// group has a label and a subset of users. To make this operation easier, we're
		// using this set of operators to break out the parts that are unique to each
		// group (ie, getting the grouping facet and defining the label).
		var operators = {
			"user.id": {
				getFacet: ( user: EnhancedUser ) => "all",
				getLabel: ( facet: string ) => "All users"
			},
			"user.email": {
				getFacet: ( user: EnhancedUser ) => `${ user.emailDomain }`,
				getLabel: ( facet: string ) => `Email ending with: ${ facet }`
			},
			"user.role": {
				getFacet: ( user: EnhancedUser ) => `${ user.role }`,
				getLabel: ( facet: string ) => `Role: ${ facet }`
			},
			"user.company.id": {
				getFacet: ( user: EnhancedUser ) => `${ user.company.id }`,
				getLabel: ( facet: string ) => `Company ID: ${ facet }`
			},
			"user.company.subdomain": {
				getFacet: ( user: EnhancedUser ) => `${ user.company.subdomain }`,
				getLabel: ( facet: string ) => `Company subdomain: ${ facet }`
			},
			"user.company.fortune100": {
				getFacet: ( user: EnhancedUser ) => `${ user.company.fortune100 }`,
				getLabel: ( facet: string ) => `Fortune 100: ${ facet }`
			},
			"user.company.fortune500": {
				getFacet: ( user: EnhancedUser ) => `${ user.company.fortune500 }`,
				getLabel: ( facet: string ) => `Fortune 500: ${ facet }`
			},
			"user.groups.betaTester": {
				getFacet: ( user: EnhancedUser ) => `${ user.groups.betaTester }`,
				getLabel: ( facet: string ) => `Beta tester: ${ facet }`
			},
			"user.groups.influencer": {
				getFacet: ( user: EnhancedUser ) => `${ user.groups.influencer }`,
				getLabel: ( facet: string ) => `Influencer: ${ facet }`
			}
		};

		if ( ! operators.hasOwnProperty( this.routeInputs.sortOn ) ) {

			return;

		}

		// Note: I'm casting to "any" here so that TypeScript doesn't complain. The guard
		// statements above should already be handling any errors.
		var operator = ( operators as any )[ this.routeInputs.sortOn ];
		var groupIndex = Object.create( null );

		this.groups = [];

		for ( var user of this.enhancedUsers ) {

			var facet = operator.getFacet( user );

			if ( ! groupIndex[ facet ] ) {

				groupIndex[ facet ] = {
					name: operator.getLabel( facet ),
					users: []
				};
				this.groups.push( groupIndex[ facet ] );

			}

			groupIndex[ facet ].users.push( user );

		}

	}

}
