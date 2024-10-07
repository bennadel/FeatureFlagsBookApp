<cfscript>

	subdomains = [
		"bytech", "cybercore", "cybernetics", "datalynk", "datasync", "digitalsys",
		"fusionworks", "futuretech", "infocorp", "infologic", "infotech", "infowave",
		"innovaplex", "megacorp", "netfusion", "nexsol", "nextbyte", "nextech",
		"primetech", "quantumsoft", "softgen", "starcorp", "sysmax", "sysnova",
		"techgenius", "techhub", "techlink", "techtide", "techwave", "ultralink"
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

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	companyID = 1000;
	companies = [];

	// We need the companies to be unique. As such, we're not going to simply pull random
	// values from the subdomains list. Instead, we're going to shuffle the subdomains
	// collection and then just read items off the head.
	shuffleValues( subdomains );

	// 10 companies.
	for ( i = 1 ; i <= 10 ; i++ ) {

		// The first company should be fortune 100.
		if ( i == 1 ) {

			fortune100 = true;
			fortune500 = false;

		// Every other company should be randomly in fortune 500.
		} else {

			fortune100 = false;
			fortune500 = randomTrue( 3 );

		}

		companies.append([
			id: ++companyID,
			subdomain: subdomains[ i ],
			fortune100: fortune100,
			fortune500: fortune500
		]);

	}

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	userID = 0;
	users = [];

	for ( company in companies ) {

		// For each of 10 companies, 10 users (100 demo users in total).
		for ( i = 1 ; i <= 10 ; i++ ) {

			firstName = randomValue( firstNames );
			lastName = randomValue( lastNames );

			// First user role should always be Admin, all other roles are random.
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

	/**
	* I shuffle the given array (in place) and return the reference.
	*/
	public array function shuffleValues( required array values ) {

		createObject( "java", "java.util.Collections" )
			.shuffle( values )
		;

		return values;

	}

</cfscript>

<!--- Pretty-print the ColdFusion data using JavaScript's JSON implementation. --->
<pre><code id="prettyprint"></code></pre>

<script type="text/javascript">

	data = JSON.parse( "<cfoutput>#encodeForJavaScript( serializeJson( users ) )#</cfoutput>" );

	window.prettyprint.textContent = JSON.stringify( data, null, "	" );

</script>
