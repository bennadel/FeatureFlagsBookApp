component
	output = false
	hint = "I provide user data for the demo (for the feature flag evaluation experience)."
	{

	// Define properties for dependency-injection.
	property name="sharedUsers" ioc:skip;

	/**
	* I initialize the demo users.
	*/
	public void function init() {

		variables.sharedUsers = buildSharedUsers();

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I provide a set of users against which to evaluate feature flags. In order to make
	* the experience a little easier to consume, several users are added on-the-fly based
	* on the given authenticated email address. This way, the user can search for their
	* own email domain.
	*/
	public array function getUsers( required string authenticatedEmail ) {

		return [
			// Since this collection is static (ie, never add or remove elemets), it is
			// thread-safe and can be iterated over via concurrent requests.
			...sharedUsers,

			// Unique users based on the logged-in user's email address.
			...buildAuthenticatedUsers( authenticatedEmail )
		];

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I generate several demo users based on the email address of the authenticated user.
	*/
	private array function buildAuthenticatedUsers( required string authenticatedEmail ) {

		var emailDomain = listRest( authenticatedEmail, "@" ).lcase();
		var emailUser = listFirst( authenticatedEmail, "@" );
		var id = 101;
		var names = [ "Admin", "Manager", "Support", "Engineer", "Analyst" ];

		var authUser = {
			"id": id++,
			"name": emailUser.reReplace( "\b(\w)", "\u\1", "all" ),
			"email": authenticatedEmail,
			"emailUser": emailUser,
			"emailDomain": "@#emailDomain#",
			"role": "admin",
			"company": {
				"id": 99999,
				"subdomain": "devteam",
				"fortune100": false,
				"fortune500": false
			},
			"groups": {
				"betaTester": true,
				"influencer": true
			},
			"isShared": false
		};
		var genericUsers = names.map(
			( name ) => {

				return {
					"id": id++,
					"name": name,
					"email": "#lcase( name )#@#emailDomain#",
					"emailUser": lcase( name ),
					"emailDomain": "@#emailDomain#",
					"role": "#lcase( name )#",
					"company": {
						"id": 99999,
						"subdomain": "devteam",
						"fortune100": false,
						"fortune500": false
					},
					"groups": {
						"betaTester": true,
						"influencer": false
					},
					"isShared": false
				};

			}
		);

		return [ authUser, ...genericUsers ];

	}


	/**
	* I build the core users. These users are status and arer shared across the demo.
	* 
	* Note: These user names and company subdomains were randomly generated via ChatGPT.
	* They aren't intended to match any real people or companies.
	*/
	private array function buildSharedUsers() {

		return [
			{
				"id": 1,
				"name": "Emily Thomas",
				"email": "emily.thomas@techgenius.example.com",
				"emailUser": "emily.thomas",
				"emailDomain": "@techgenius.example.com",
				"role": "admin",
				"company": {
					"id": 12301,
					"subdomain": "techgenius",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 2,
				"name": "David Mitchell",
				"email": "david.mitchell@techgenius.example.com",
				"emailUser": "david.mitchell",
				"emailDomain": "@techgenius.example.com",
				"role": "analyst",
				"company": {
					"id": 12301,
					"subdomain": "techgenius",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 3,
				"name": "Dylan Lee",
				"email": "dylan.lee@techgenius.example.com",
				"emailUser": "dylan.lee",
				"emailDomain": "@techgenius.example.com",
				"role": "engineer",
				"company": {
					"id": 12301,
					"subdomain": "techgenius",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 4,
				"name": "Riley Smith",
				"email": "riley.smith@techgenius.example.com",
				"emailUser": "riley.smith",
				"emailDomain": "@techgenius.example.com",
				"role": "admin",
				"company": {
					"id": 12301,
					"subdomain": "techgenius",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 5,
				"name": "Joseph Jackson",
				"email": "joseph.jackson@techgenius.example.com",
				"emailUser": "joseph.jackson",
				"emailDomain": "@techgenius.example.com",
				"role": "engineer",
				"company": {
					"id": 12301,
					"subdomain": "techgenius",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 6,
				"name": "David Jones",
				"email": "david.jones@techgenius.example.com",
				"emailUser": "david.jones",
				"emailDomain": "@techgenius.example.com",
				"role": "manager",
				"company": {
					"id": 12301,
					"subdomain": "techgenius",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 7,
				"name": "Ellie Mitchell",
				"email": "ellie.mitchell@techgenius.example.com",
				"emailUser": "ellie.mitchell",
				"emailDomain": "@techgenius.example.com",
				"role": "engineer",
				"company": {
					"id": 12301,
					"subdomain": "techgenius",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 8,
				"name": "Ethan Scott",
				"email": "ethan.scott@techgenius.example.com",
				"emailUser": "ethan.scott",
				"emailDomain": "@techgenius.example.com",
				"role": "analyst",
				"company": {
					"id": 12301,
					"subdomain": "techgenius",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 9,
				"name": "Luna Rodriguez",
				"email": "luna.rodriguez@techgenius.example.com",
				"emailUser": "luna.rodriguez",
				"emailDomain": "@techgenius.example.com",
				"role": "admin",
				"company": {
					"id": 12301,
					"subdomain": "techgenius",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 10,
				"name": "Nova Gonzalez",
				"email": "nova.gonzalez@techgenius.example.com",
				"emailUser": "nova.gonzalez",
				"emailDomain": "@techgenius.example.com",
				"role": "engineer",
				"company": {
					"id": 12301,
					"subdomain": "techgenius",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 11,
				"name": "Michael Williams",
				"email": "michael.williams@starcorp.example.com",
				"emailUser": "michael.williams",
				"emailDomain": "@starcorp.example.com",
				"role": "admin",
				"company": {
					"id": 12302,
					"subdomain": "starcorp",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 12,
				"name": "Lincoln White",
				"email": "lincoln.white@starcorp.example.com",
				"emailUser": "lincoln.white",
				"emailDomain": "@starcorp.example.com",
				"role": "engineer",
				"company": {
					"id": 12302,
					"subdomain": "starcorp",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 13,
				"name": "Benjamin Davis",
				"email": "benjamin.davis@starcorp.example.com",
				"emailUser": "benjamin.davis",
				"emailDomain": "@starcorp.example.com",
				"role": "analyst",
				"company": {
					"id": 12302,
					"subdomain": "starcorp",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 14,
				"name": "Grayson Miller",
				"email": "grayson.miller@starcorp.example.com",
				"emailUser": "grayson.miller",
				"emailDomain": "@starcorp.example.com",
				"role": "support",
				"company": {
					"id": 12302,
					"subdomain": "starcorp",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 15,
				"name": "Carter Roberts",
				"email": "carter.roberts@starcorp.example.com",
				"emailUser": "carter.roberts",
				"emailDomain": "@starcorp.example.com",
				"role": "analyst",
				"company": {
					"id": 12302,
					"subdomain": "starcorp",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 16,
				"name": "Bella King",
				"email": "bella.king@starcorp.example.com",
				"emailUser": "bella.king",
				"emailDomain": "@starcorp.example.com",
				"role": "admin",
				"company": {
					"id": 12302,
					"subdomain": "starcorp",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 17,
				"name": "Owen Nelson",
				"email": "owen.nelson@starcorp.example.com",
				"emailUser": "owen.nelson",
				"emailDomain": "@starcorp.example.com",
				"role": "engineer",
				"company": {
					"id": 12302,
					"subdomain": "starcorp",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 18,
				"name": "Hudson Nguyen",
				"email": "hudson.nguyen@starcorp.example.com",
				"emailUser": "hudson.nguyen",
				"emailDomain": "@starcorp.example.com",
				"role": "manager",
				"company": {
					"id": 12302,
					"subdomain": "starcorp",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 19,
				"name": "Logan Nelson",
				"email": "logan.nelson@starcorp.example.com",
				"emailUser": "logan.nelson",
				"emailDomain": "@starcorp.example.com",
				"role": "admin",
				"company": {
					"id": 12302,
					"subdomain": "starcorp",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 20,
				"name": "Audrey Baker",
				"email": "audrey.baker@starcorp.example.com",
				"emailUser": "audrey.baker",
				"emailDomain": "@starcorp.example.com",
				"role": "admin",
				"company": {
					"id": 12302,
					"subdomain": "starcorp",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 21,
				"name": "Daniel Smith",
				"email": "daniel.smith@fusionworks.example.com",
				"emailUser": "daniel.smith",
				"emailDomain": "@fusionworks.example.com",
				"role": "admin",
				"company": {
					"id": 12303,
					"subdomain": "fusionworks",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 22,
				"name": "Asher Lopez",
				"email": "asher.lopez@fusionworks.example.com",
				"emailUser": "asher.lopez",
				"emailDomain": "@fusionworks.example.com",
				"role": "engineer",
				"company": {
					"id": 12303,
					"subdomain": "fusionworks",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 23,
				"name": "Hazel Wilson",
				"email": "hazel.wilson@fusionworks.example.com",
				"emailUser": "hazel.wilson",
				"emailDomain": "@fusionworks.example.com",
				"role": "support",
				"company": {
					"id": 12303,
					"subdomain": "fusionworks",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 24,
				"name": "Zoe Moore",
				"email": "zoe.moore@fusionworks.example.com",
				"emailUser": "zoe.moore",
				"emailDomain": "@fusionworks.example.com",
				"role": "support",
				"company": {
					"id": 12303,
					"subdomain": "fusionworks",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 25,
				"name": "Charles Rivera",
				"email": "charles.rivera@fusionworks.example.com",
				"emailUser": "charles.rivera",
				"emailDomain": "@fusionworks.example.com",
				"role": "support",
				"company": {
					"id": 12303,
					"subdomain": "fusionworks",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 26,
				"name": "Sebastian King",
				"email": "sebastian.king@fusionworks.example.com",
				"emailUser": "sebastian.king",
				"emailDomain": "@fusionworks.example.com",
				"role": "support",
				"company": {
					"id": 12303,
					"subdomain": "fusionworks",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 27,
				"name": "Eleanor Rivera",
				"email": "eleanor.rivera@fusionworks.example.com",
				"emailUser": "eleanor.rivera",
				"emailDomain": "@fusionworks.example.com",
				"role": "manager",
				"company": {
					"id": 12303,
					"subdomain": "fusionworks",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 28,
				"name": "Lillian Nguyen",
				"email": "lillian.nguyen@fusionworks.example.com",
				"emailUser": "lillian.nguyen",
				"emailDomain": "@fusionworks.example.com",
				"role": "support",
				"company": {
					"id": 12303,
					"subdomain": "fusionworks",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 29,
				"name": "Sebastian Jones",
				"email": "sebastian.jones@fusionworks.example.com",
				"emailUser": "sebastian.jones",
				"emailDomain": "@fusionworks.example.com",
				"role": "admin",
				"company": {
					"id": 12303,
					"subdomain": "fusionworks",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 30,
				"name": "Samuel Roberts",
				"email": "samuel.roberts@fusionworks.example.com",
				"emailUser": "samuel.roberts",
				"emailDomain": "@fusionworks.example.com",
				"role": "manager",
				"company": {
					"id": 12303,
					"subdomain": "fusionworks",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 31,
				"name": "Hannah Perez",
				"email": "hannah.perez@nexsol.example.com",
				"emailUser": "hannah.perez",
				"emailDomain": "@nexsol.example.com",
				"role": "admin",
				"company": {
					"id": 12304,
					"subdomain": "nexsol",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 32,
				"name": "Alexander Martin",
				"email": "alexander.martin@nexsol.example.com",
				"emailUser": "alexander.martin",
				"emailDomain": "@nexsol.example.com",
				"role": "analyst",
				"company": {
					"id": 12304,
					"subdomain": "nexsol",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 33,
				"name": "Bella Perez",
				"email": "bella.perez@nexsol.example.com",
				"emailUser": "bella.perez",
				"emailDomain": "@nexsol.example.com",
				"role": "admin",
				"company": {
					"id": 12304,
					"subdomain": "nexsol",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 34,
				"name": "Nova Taylor",
				"email": "nova.taylor@nexsol.example.com",
				"emailUser": "nova.taylor",
				"emailDomain": "@nexsol.example.com",
				"role": "analyst",
				"company": {
					"id": 12304,
					"subdomain": "nexsol",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": true
				},
				"isShared": true
			},
			{
				"id": 35,
				"name": "Violet Hall",
				"email": "violet.hall@nexsol.example.com",
				"emailUser": "violet.hall",
				"emailDomain": "@nexsol.example.com",
				"role": "analyst",
				"company": {
					"id": 12304,
					"subdomain": "nexsol",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 36,
				"name": "Lucy Hill",
				"email": "lucy.hill@nexsol.example.com",
				"emailUser": "lucy.hill",
				"emailDomain": "@nexsol.example.com",
				"role": "manager",
				"company": {
					"id": 12304,
					"subdomain": "nexsol",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 37,
				"name": "Dylan White",
				"email": "dylan.white@nexsol.example.com",
				"emailUser": "dylan.white",
				"emailDomain": "@nexsol.example.com",
				"role": "support",
				"company": {
					"id": 12304,
					"subdomain": "nexsol",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 38,
				"name": "Eleanor Young",
				"email": "eleanor.young@nexsol.example.com",
				"emailUser": "eleanor.young",
				"emailDomain": "@nexsol.example.com",
				"role": "analyst",
				"company": {
					"id": 12304,
					"subdomain": "nexsol",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 39,
				"name": "Owen Baker",
				"email": "owen.baker@nexsol.example.com",
				"emailUser": "owen.baker",
				"emailDomain": "@nexsol.example.com",
				"role": "admin",
				"company": {
					"id": 12304,
					"subdomain": "nexsol",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 40,
				"name": "Hannah Garcia",
				"email": "hannah.garcia@nexsol.example.com",
				"emailUser": "hannah.garcia",
				"emailDomain": "@nexsol.example.com",
				"role": "engineer",
				"company": {
					"id": 12304,
					"subdomain": "nexsol",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 41,
				"name": "Elijah Anderson",
				"email": "elijah.anderson@primetech.example.com",
				"emailUser": "elijah.anderson",
				"emailDomain": "@primetech.example.com",
				"role": "admin",
				"company": {
					"id": 12305,
					"subdomain": "primetech",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 42,
				"name": "Christopher Taylor",
				"email": "christopher.taylor@primetech.example.com",
				"emailUser": "christopher.taylor",
				"emailDomain": "@primetech.example.com",
				"role": "support",
				"company": {
					"id": 12305,
					"subdomain": "primetech",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": true
				},
				"isShared": true
			},
			{
				"id": 43,
				"name": "Harper Jones",
				"email": "harper.jones@primetech.example.com",
				"emailUser": "harper.jones",
				"emailDomain": "@primetech.example.com",
				"role": "admin",
				"company": {
					"id": 12305,
					"subdomain": "primetech",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": true
				},
				"isShared": true
			},
			{
				"id": 44,
				"name": "Harper Thompson",
				"email": "harper.thompson@primetech.example.com",
				"emailUser": "harper.thompson",
				"emailDomain": "@primetech.example.com",
				"role": "manager",
				"company": {
					"id": 12305,
					"subdomain": "primetech",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 45,
				"name": "Sofia Clark",
				"email": "sofia.clark@primetech.example.com",
				"emailUser": "sofia.clark",
				"emailDomain": "@primetech.example.com",
				"role": "analyst",
				"company": {
					"id": 12305,
					"subdomain": "primetech",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 46,
				"name": "Maverick Allen",
				"email": "maverick.allen@primetech.example.com",
				"emailUser": "maverick.allen",
				"emailDomain": "@primetech.example.com",
				"role": "manager",
				"company": {
					"id": 12305,
					"subdomain": "primetech",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 47,
				"name": "Ava Smith",
				"email": "ava.smith@primetech.example.com",
				"emailUser": "ava.smith",
				"emailDomain": "@primetech.example.com",
				"role": "manager",
				"company": {
					"id": 12305,
					"subdomain": "primetech",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 48,
				"name": "Bella Torres",
				"email": "bella.torres@primetech.example.com",
				"emailUser": "bella.torres",
				"emailDomain": "@primetech.example.com",
				"role": "analyst",
				"company": {
					"id": 12305,
					"subdomain": "primetech",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 49,
				"name": "Avery Williams",
				"email": "avery.williams@primetech.example.com",
				"emailUser": "avery.williams",
				"emailDomain": "@primetech.example.com",
				"role": "admin",
				"company": {
					"id": 12305,
					"subdomain": "primetech",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 50,
				"name": "Alexander Thomas",
				"email": "alexander.thomas@primetech.example.com",
				"emailUser": "alexander.thomas",
				"emailDomain": "@primetech.example.com",
				"role": "analyst",
				"company": {
					"id": 12305,
					"subdomain": "primetech",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 51,
				"name": "Layla Young",
				"email": "layla.young@innovaplex.example.com",
				"emailUser": "layla.young",
				"emailDomain": "@innovaplex.example.com",
				"role": "admin",
				"company": {
					"id": 12306,
					"subdomain": "innovaplex",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 52,
				"name": "Leah Hernandez",
				"email": "leah.hernandez@innovaplex.example.com",
				"emailUser": "leah.hernandez",
				"emailDomain": "@innovaplex.example.com",
				"role": "manager",
				"company": {
					"id": 12306,
					"subdomain": "innovaplex",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 53,
				"name": "Dylan Wright",
				"email": "dylan.wright@innovaplex.example.com",
				"emailUser": "dylan.wright",
				"emailDomain": "@innovaplex.example.com",
				"role": "analyst",
				"company": {
					"id": 12306,
					"subdomain": "innovaplex",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 54,
				"name": "Leo Rivera",
				"email": "leo.rivera@innovaplex.example.com",
				"emailUser": "leo.rivera",
				"emailDomain": "@innovaplex.example.com",
				"role": "manager",
				"company": {
					"id": 12306,
					"subdomain": "innovaplex",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 55,
				"name": "Emilia Rivera",
				"email": "emilia.rivera@innovaplex.example.com",
				"emailUser": "emilia.rivera",
				"emailDomain": "@innovaplex.example.com",
				"role": "analyst",
				"company": {
					"id": 12306,
					"subdomain": "innovaplex",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 56,
				"name": "Everly Jackson",
				"email": "everly.jackson@innovaplex.example.com",
				"emailUser": "everly.jackson",
				"emailDomain": "@innovaplex.example.com",
				"role": "admin",
				"company": {
					"id": 12306,
					"subdomain": "innovaplex",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 57,
				"name": "Hannah Young",
				"email": "hannah.young@innovaplex.example.com",
				"emailUser": "hannah.young",
				"emailDomain": "@innovaplex.example.com",
				"role": "engineer",
				"company": {
					"id": 12306,
					"subdomain": "innovaplex",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 58,
				"name": "Anthony Roberts",
				"email": "anthony.roberts@innovaplex.example.com",
				"emailUser": "anthony.roberts",
				"emailDomain": "@innovaplex.example.com",
				"role": "admin",
				"company": {
					"id": 12306,
					"subdomain": "innovaplex",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 59,
				"name": "Nora Johnson",
				"email": "nora.johnson@innovaplex.example.com",
				"emailUser": "nora.johnson",
				"emailDomain": "@innovaplex.example.com",
				"role": "manager",
				"company": {
					"id": 12306,
					"subdomain": "innovaplex",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 60,
				"name": "Ellie Harris",
				"email": "ellie.harris@innovaplex.example.com",
				"emailUser": "ellie.harris",
				"emailDomain": "@innovaplex.example.com",
				"role": "admin",
				"company": {
					"id": 12306,
					"subdomain": "innovaplex",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 61,
				"name": "Violet Hill",
				"email": "violet.hill@quantumsoft.example.com",
				"emailUser": "violet.hill",
				"emailDomain": "@quantumsoft.example.com",
				"role": "admin",
				"company": {
					"id": 12307,
					"subdomain": "quantumsoft",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 62,
				"name": "Mia Harris",
				"email": "mia.harris@quantumsoft.example.com",
				"emailUser": "mia.harris",
				"emailDomain": "@quantumsoft.example.com",
				"role": "admin",
				"company": {
					"id": 12307,
					"subdomain": "quantumsoft",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 63,
				"name": "Elijah Perez",
				"email": "elijah.perez@quantumsoft.example.com",
				"emailUser": "elijah.perez",
				"emailDomain": "@quantumsoft.example.com",
				"role": "manager",
				"company": {
					"id": 12307,
					"subdomain": "quantumsoft",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 64,
				"name": "Owen Green",
				"email": "owen.green@quantumsoft.example.com",
				"emailUser": "owen.green",
				"emailDomain": "@quantumsoft.example.com",
				"role": "support",
				"company": {
					"id": 12307,
					"subdomain": "quantumsoft",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 65,
				"name": "Luna Johnson",
				"email": "luna.johnson@quantumsoft.example.com",
				"emailUser": "luna.johnson",
				"emailDomain": "@quantumsoft.example.com",
				"role": "manager",
				"company": {
					"id": 12307,
					"subdomain": "quantumsoft",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 66,
				"name": "Joseph Jones",
				"email": "joseph.jones@quantumsoft.example.com",
				"emailUser": "joseph.jones",
				"emailDomain": "@quantumsoft.example.com",
				"role": "analyst",
				"company": {
					"id": 12307,
					"subdomain": "quantumsoft",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 67,
				"name": "Violet Adams",
				"email": "violet.adams@quantumsoft.example.com",
				"emailUser": "violet.adams",
				"emailDomain": "@quantumsoft.example.com",
				"role": "analyst",
				"company": {
					"id": 12307,
					"subdomain": "quantumsoft",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 68,
				"name": "Lily Davis",
				"email": "lily.davis@quantumsoft.example.com",
				"emailUser": "lily.davis",
				"emailDomain": "@quantumsoft.example.com",
				"role": "support",
				"company": {
					"id": 12307,
					"subdomain": "quantumsoft",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 69,
				"name": "Zoe Williams",
				"email": "zoe.williams@quantumsoft.example.com",
				"emailUser": "zoe.williams",
				"emailDomain": "@quantumsoft.example.com",
				"role": "engineer",
				"company": {
					"id": 12307,
					"subdomain": "quantumsoft",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 70,
				"name": "Isabella Wilson",
				"email": "isabella.wilson@quantumsoft.example.com",
				"emailUser": "isabella.wilson",
				"emailDomain": "@quantumsoft.example.com",
				"role": "manager",
				"company": {
					"id": 12307,
					"subdomain": "quantumsoft",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 71,
				"name": "Jack Clark",
				"email": "jack.clark@megacorp.example.com",
				"emailUser": "jack.clark",
				"emailDomain": "@megacorp.example.com",
				"role": "admin",
				"company": {
					"id": 12308,
					"subdomain": "megacorp",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 72,
				"name": "Camila Roberts",
				"email": "camila.roberts@megacorp.example.com",
				"emailUser": "camila.roberts",
				"emailDomain": "@megacorp.example.com",
				"role": "engineer",
				"company": {
					"id": 12308,
					"subdomain": "megacorp",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 73,
				"name": "Hazel Wright",
				"email": "hazel.wright@megacorp.example.com",
				"emailUser": "hazel.wright",
				"emailDomain": "@megacorp.example.com",
				"role": "analyst",
				"company": {
					"id": 12308,
					"subdomain": "megacorp",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 74,
				"name": "Ava Allen",
				"email": "ava.allen@megacorp.example.com",
				"emailUser": "ava.allen",
				"emailDomain": "@megacorp.example.com",
				"role": "support",
				"company": {
					"id": 12308,
					"subdomain": "megacorp",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 75,
				"name": "Daniel Ramirez",
				"email": "daniel.ramirez@megacorp.example.com",
				"emailUser": "daniel.ramirez",
				"emailDomain": "@megacorp.example.com",
				"role": "analyst",
				"company": {
					"id": 12308,
					"subdomain": "megacorp",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": true
				},
				"isShared": true
			},
			{
				"id": 76,
				"name": "Leo Torres",
				"email": "leo.torres@megacorp.example.com",
				"emailUser": "leo.torres",
				"emailDomain": "@megacorp.example.com",
				"role": "manager",
				"company": {
					"id": 12308,
					"subdomain": "megacorp",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 77,
				"name": "Lucas Young",
				"email": "lucas.young@megacorp.example.com",
				"emailUser": "lucas.young",
				"emailDomain": "@megacorp.example.com",
				"role": "engineer",
				"company": {
					"id": 12308,
					"subdomain": "megacorp",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 78,
				"name": "Thomas Young",
				"email": "thomas.young@megacorp.example.com",
				"emailUser": "thomas.young",
				"emailDomain": "@megacorp.example.com",
				"role": "engineer",
				"company": {
					"id": 12308,
					"subdomain": "megacorp",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 79,
				"name": "William Wright",
				"email": "william.wright@megacorp.example.com",
				"emailUser": "william.wright",
				"emailDomain": "@megacorp.example.com",
				"role": "support",
				"company": {
					"id": 12308,
					"subdomain": "megacorp",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 80,
				"name": "Joseph Moore",
				"email": "joseph.moore@megacorp.example.com",
				"emailUser": "joseph.moore",
				"emailDomain": "@megacorp.example.com",
				"role": "support",
				"company": {
					"id": 12308,
					"subdomain": "megacorp",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 81,
				"name": "Josiah Nguyen",
				"email": "josiah.nguyen@ultralink.example.com",
				"emailUser": "josiah.nguyen",
				"emailDomain": "@ultralink.example.com",
				"role": "admin",
				"company": {
					"id": 12309,
					"subdomain": "ultralink",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 82,
				"name": "Jack Perez",
				"email": "jack.perez@ultralink.example.com",
				"emailUser": "jack.perez",
				"emailDomain": "@ultralink.example.com",
				"role": "analyst",
				"company": {
					"id": 12309,
					"subdomain": "ultralink",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 83,
				"name": "James Allen",
				"email": "james.allen@ultralink.example.com",
				"emailUser": "james.allen",
				"emailDomain": "@ultralink.example.com",
				"role": "support",
				"company": {
					"id": 12309,
					"subdomain": "ultralink",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 84,
				"name": "Zoe Harris",
				"email": "zoe.harris@ultralink.example.com",
				"emailUser": "zoe.harris",
				"emailDomain": "@ultralink.example.com",
				"role": "support",
				"company": {
					"id": 12309,
					"subdomain": "ultralink",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 85,
				"name": "Isabella Smith",
				"email": "isabella.smith@ultralink.example.com",
				"emailUser": "isabella.smith",
				"emailDomain": "@ultralink.example.com",
				"role": "admin",
				"company": {
					"id": 12309,
					"subdomain": "ultralink",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 86,
				"name": "Leah Roberts",
				"email": "leah.roberts@ultralink.example.com",
				"emailUser": "leah.roberts",
				"emailDomain": "@ultralink.example.com",
				"role": "support",
				"company": {
					"id": 12309,
					"subdomain": "ultralink",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 87,
				"name": "Hazel Baker",
				"email": "hazel.baker@ultralink.example.com",
				"emailUser": "hazel.baker",
				"emailDomain": "@ultralink.example.com",
				"role": "analyst",
				"company": {
					"id": 12309,
					"subdomain": "ultralink",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 88,
				"name": "Aurora Torres",
				"email": "aurora.torres@ultralink.example.com",
				"emailUser": "aurora.torres",
				"emailDomain": "@ultralink.example.com",
				"role": "manager",
				"company": {
					"id": 12309,
					"subdomain": "ultralink",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 89,
				"name": "Michael Young",
				"email": "michael.young@ultralink.example.com",
				"emailUser": "michael.young",
				"emailDomain": "@ultralink.example.com",
				"role": "engineer",
				"company": {
					"id": 12309,
					"subdomain": "ultralink",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 90,
				"name": "Emma Harris",
				"email": "emma.harris@ultralink.example.com",
				"emailUser": "emma.harris",
				"emailDomain": "@ultralink.example.com",
				"role": "support",
				"company": {
					"id": 12309,
					"subdomain": "ultralink",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 91,
				"name": "Charles Miller",
				"email": "charles.miller@futuretech.example.com",
				"emailUser": "charles.miller",
				"emailDomain": "@futuretech.example.com",
				"role": "admin",
				"company": {
					"id": 12310,
					"subdomain": "futuretech",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 92,
				"name": "Maverick Anderson",
				"email": "maverick.anderson@futuretech.example.com",
				"emailUser": "maverick.anderson",
				"emailDomain": "@futuretech.example.com",
				"role": "support",
				"company": {
					"id": 12310,
					"subdomain": "futuretech",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 93,
				"name": "Lillian Smith",
				"email": "lillian.smith@futuretech.example.com",
				"emailUser": "lillian.smith",
				"emailDomain": "@futuretech.example.com",
				"role": "analyst",
				"company": {
					"id": 12310,
					"subdomain": "futuretech",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": true
				},
				"isShared": true
			},
			{
				"id": 94,
				"name": "Addison Adams",
				"email": "addison.adams@futuretech.example.com",
				"emailUser": "addison.adams",
				"emailDomain": "@futuretech.example.com",
				"role": "support",
				"company": {
					"id": 12310,
					"subdomain": "futuretech",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 95,
				"name": "Layla Robinson",
				"email": "layla.robinson@futuretech.example.com",
				"emailUser": "layla.robinson",
				"emailDomain": "@futuretech.example.com",
				"role": "admin",
				"company": {
					"id": 12310,
					"subdomain": "futuretech",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 96,
				"name": "Levi Sanchez",
				"email": "levi.sanchez@futuretech.example.com",
				"emailUser": "levi.sanchez",
				"emailDomain": "@futuretech.example.com",
				"role": "admin",
				"company": {
					"id": 12310,
					"subdomain": "futuretech",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 97,
				"name": "Kath Day",
				"email": "kath.day@dayknight.example.com",
				"emailUser": "kath.day",
				"emailDomain": "@dayknight.example.com",
				"role": "admin",
				"company": {
					"id": 12311,
					"subdomain": "dayknight",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 98,
				"name": "Kim Day",
				"email": "kim.day@dayknight.example.com",
				"emailUser": "kim.day",
				"emailDomain": "@dayknight.example.com",
				"role": "support",
				"company": {
					"id": 12311,
					"subdomain": "dayknight",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 99,
				"name": "Sharon Strzelecki",
				"email": "sharon.strzelecki@dayknight.example.com",
				"emailUser": "sharon.strzelecki",
				"emailDomain": "@dayknight.example.com",
				"role": "manager",
				"company": {
					"id": 12311,
					"subdomain": "dayknight",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				},
				"isShared": true
			},
			{
				"id": 100,
				"name": "Kel Knight",
				"email": "kel.knight@dayknight.example.com",
				"emailUser": "kel.knight",
				"emailDomain": "@dayknight.example.com",
				"role": "engineer",
				"company": {
					"id": 12311,
					"subdomain": "dayknight",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				},
				"isShared": true
			}
		];

	}

}
