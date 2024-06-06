<cfscript>

	companies = [
		[
			id: 12301,
			subdomain: "techgenius",
			fortune100: true,
			fortune500: false
		],
		[
			id: 12302,
			subdomain: "starcorp",
			fortune100: true,
			fortune500: false
		],
		[
			id: 12303,
			subdomain: "fusionworks",
			fortune100: false,
			fortune500: true
		],
		[
			id: 12304,
			subdomain: "nexsol",
			fortune100: false,
			fortune500: true
		],
		[
			id: 12305,
			subdomain: "primetech",
			fortune100: false,
			fortune500: true
		],
		[
			id: 12306,
			subdomain: "innovaplex",
			fortune100: false,
			fortune500: false
		],
		[
			id: 12307,
			subdomain: "quantumsoft",
			fortune100: false,
			fortune500: false
		],
		[
			id: 12308,
			subdomain: "megacorp",
			fortune100: false,
			fortune500: false
		],
		[
			id: 12309,
			subdomain: "ultralink",
			fortune100: false,
			fortune500: false
		],
		[
			id: 12310,
			subdomain: "futuretech",
			fortune100: false,
			fortune500: false
		]
	];

	firstNames = [
		"Abigail", "Addison", "Aiden", "Alexander", "Amelia", "Anthony", "Aria", "Asher",
		"Aubrey", "Audrey", "Aurora", "Ava", "Avery", "Bella", "Benjamin", "Camila",
		"Carter", "Charles", "Chloe", "Christopher", "Daniel", "David", "Dylan",
		"Eleanor", "Elijah", "Elizabeth", "Ella", "Ellie", "Emilia", "Emily", "Emma",
		"Ethan", "Evelyn", "Everly", "Ezra", "Gabriel", "Grace", "Grayson", "Hannah",
		"Harper", "Hazel", "Henry", "Hudson", "Isaac", "Isabella", "Jack", "Jackson",
		"Jacob", "James", "Jaxon", "Jayden", "John", "Joseph", "Josiah", "Julian",
		"Layla", "Leah", "Leo", "Levi", "Liam", "Lillian", "Lily", "Lincoln", "Logan",
		"Lucas", "Lucy", "Luke", "Luna", "Madison", "Mason", "Mateo", "Matthew",
		"Maverick", "Mia", "Michael", "Mila", "Natalie", "Noah", "Nora", "Nova", "Oliver",
		"Olivia", "Owen", "Penelope", "Riley", "Samuel", "Scarlett", "Sebastian", "Sofia",
		"Sophia", "Stella", "Theodore", "Thomas", "Victoria", "Violet", "William",
		"Willow", "Wyatt", "Zoe", "Zoey"
	];
	lastNames = [
		"Adams", "Allen", "Anderson", "Baker", "Brown", "Campbell", "Carter", "Clark",
		"Davis", "Flores", "Garcia", "Gonzalez", "Green", "Hall", "Harris", "Hernandez",
		"Hill", "Jackson", "Johnson", "Jones", "King", "Lee", "Lewis", "Lopez", "Martin",
		"Martinez", "Miller", "Mitchell", "Moore", "Nelson", "Nguyen", "Perez", "Ramirez",
		"Rivera", "Roberts", "Robinson", "Rodriguez", "Sanchez", "Scott", "Smith",
		"Taylor", "Thomas", "Thompson", "Torres", "Walker", "White", "Williams", "Wilson",
		"Wright", "Young"
	];

	roles = [ "admin", "manager", "engineer", "support", "analyst" ];

	userID = 0;
	users = [];

	for ( company in companies ) {

		for ( i = 1 ; i <= 10 ; i++ ) {

			firstName = randomValue( firstNames );
			lastName = randomValue( lastNames );

			// First role is Admin, all others are random.
			role = ( i == 1 )
				? roles[ 1 ]
				: randomValue( roles )
			;

			users.append([
				id: ++userID,
				name: "#firstName# #lastName#",
				email: lcase( "#firstName#.#lastName#@#company.subdomain#.example.com" ),
				role: role,
				company: company,
				groups: [
					betaTester: randomTrue( 5 ),
					influencer: randomTrue( 20 )
				]
			]);

		}

	}

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I return a random value from the given array.
	*/
	public any function randomValue( required array values ) {

		return values[ randRange( 1, arrayLen( values ), "sha1prng" ) ];

	}

	/**
	* I return a random True with the given 1/chance.
	*/
	public boolean function randomTrue( required numeric chance ) {

		return ( randRange( 0, chance, "sha1prng" ) == chance );

	}

</cfscript>

<!--- Pretty-print the ColdFusion data using JavaScript's JSON implementation. --->
<pre><code id="prettyprint"></code></pre>

<script type="text/javascript">

	data = JSON.parse( "<cfoutput>#encodeForJavaScript( serializeJson( users ) )#</cfoutput>" );

	window.prettyprint.textContent = JSON.stringify( data, null, "	" );

</script>
