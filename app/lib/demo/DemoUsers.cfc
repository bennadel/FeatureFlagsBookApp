component
	output = false
	hint = "I provide user data for the demo (for the feature flag evaluation experience)."
	{

	/**
	* I provide a set of users against which to evaluate feature flags.
	* 
	* Note: These user names and company subdomains were randomly generated via ChatGPT.
	* They aren't intended to match any real people or companies.
	*/
	public array function getUsers() {

		return [
			{
				"id": 1,
				"name": "Emily Thomas",
				"email": "emily.thomas@techgenius.example.com",
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
				}
			},
			{
				"id": 2,
				"name": "David Mitchell",
				"email": "david.mitchell@techgenius.example.com",
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
				}
			},
			{
				"id": 3,
				"name": "Dylan Lee",
				"email": "dylan.lee@techgenius.example.com",
				"role": "engineer",
				"company": {
					"id": 12301,
					"subdomain": "techgenius",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 4,
				"name": "Riley Smith",
				"email": "riley.smith@techgenius.example.com",
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
				}
			},
			{
				"id": 5,
				"name": "Joseph Jackson",
				"email": "joseph.jackson@techgenius.example.com",
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
				}
			},
			{
				"id": 6,
				"name": "David Jones",
				"email": "david.jones@techgenius.example.com",
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
				}
			},
			{
				"id": 7,
				"name": "Ellie Mitchell",
				"email": "ellie.mitchell@techgenius.example.com",
				"role": "engineer",
				"company": {
					"id": 12301,
					"subdomain": "techgenius",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 8,
				"name": "Ethan Scott",
				"email": "ethan.scott@techgenius.example.com",
				"role": "analyst",
				"company": {
					"id": 12301,
					"subdomain": "techgenius",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 9,
				"name": "Luna Rodriguez",
				"email": "luna.rodriguez@techgenius.example.com",
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
				}
			},
			{
				"id": 10,
				"name": "Nova Gonzalez",
				"email": "nova.gonzalez@techgenius.example.com",
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
				}
			},
			{
				"id": 11,
				"name": "Michael Williams",
				"email": "michael.williams@starcorp.example.com",
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
				}
			},
			{
				"id": 12,
				"name": "Lincoln White",
				"email": "lincoln.white@starcorp.example.com",
				"role": "engineer",
				"company": {
					"id": 12302,
					"subdomain": "starcorp",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 13,
				"name": "Benjamin Davis",
				"email": "benjamin.davis@starcorp.example.com",
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
				}
			},
			{
				"id": 14,
				"name": "Grayson Miller",
				"email": "grayson.miller@starcorp.example.com",
				"role": "support",
				"company": {
					"id": 12302,
					"subdomain": "starcorp",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 15,
				"name": "Carter Roberts",
				"email": "carter.roberts@starcorp.example.com",
				"role": "analyst",
				"company": {
					"id": 12302,
					"subdomain": "starcorp",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 16,
				"name": "Bella King",
				"email": "bella.king@starcorp.example.com",
				"role": "admin",
				"company": {
					"id": 12302,
					"subdomain": "starcorp",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 17,
				"name": "Owen Nelson",
				"email": "owen.nelson@starcorp.example.com",
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
				}
			},
			{
				"id": 18,
				"name": "Hudson Nguyen",
				"email": "hudson.nguyen@starcorp.example.com",
				"role": "manager",
				"company": {
					"id": 12302,
					"subdomain": "starcorp",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 19,
				"name": "Logan Nelson",
				"email": "logan.nelson@starcorp.example.com",
				"role": "admin",
				"company": {
					"id": 12302,
					"subdomain": "starcorp",
					"fortune100": true,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 20,
				"name": "Audrey Baker",
				"email": "audrey.baker@starcorp.example.com",
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
				}
			},
			{
				"id": 21,
				"name": "Daniel Smith",
				"email": "daniel.smith@fusionworks.example.com",
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
				}
			},
			{
				"id": 22,
				"name": "Asher Lopez",
				"email": "asher.lopez@fusionworks.example.com",
				"role": "engineer",
				"company": {
					"id": 12303,
					"subdomain": "fusionworks",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 23,
				"name": "Hazel Wilson",
				"email": "hazel.wilson@fusionworks.example.com",
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
				}
			},
			{
				"id": 24,
				"name": "Zoe Moore",
				"email": "zoe.moore@fusionworks.example.com",
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
				}
			},
			{
				"id": 25,
				"name": "Charles Rivera",
				"email": "charles.rivera@fusionworks.example.com",
				"role": "support",
				"company": {
					"id": 12303,
					"subdomain": "fusionworks",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 26,
				"name": "Sebastian King",
				"email": "sebastian.king@fusionworks.example.com",
				"role": "support",
				"company": {
					"id": 12303,
					"subdomain": "fusionworks",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 27,
				"name": "Eleanor Rivera",
				"email": "eleanor.rivera@fusionworks.example.com",
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
				}
			},
			{
				"id": 28,
				"name": "Lillian Nguyen",
				"email": "lillian.nguyen@fusionworks.example.com",
				"role": "support",
				"company": {
					"id": 12303,
					"subdomain": "fusionworks",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 29,
				"name": "Sebastian Jones",
				"email": "sebastian.jones@fusionworks.example.com",
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
				}
			},
			{
				"id": 30,
				"name": "Samuel Roberts",
				"email": "samuel.roberts@fusionworks.example.com",
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
				}
			},
			{
				"id": 31,
				"name": "Hannah Perez",
				"email": "hannah.perez@nexsol.example.com",
				"role": "admin",
				"company": {
					"id": 12304,
					"subdomain": "nexsol",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 32,
				"name": "Alexander Martin",
				"email": "alexander.martin@nexsol.example.com",
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
				}
			},
			{
				"id": 33,
				"name": "Bella Perez",
				"email": "bella.perez@nexsol.example.com",
				"role": "admin",
				"company": {
					"id": 12304,
					"subdomain": "nexsol",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 34,
				"name": "Nova Taylor",
				"email": "nova.taylor@nexsol.example.com",
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
				}
			},
			{
				"id": 35,
				"name": "Violet Hall",
				"email": "violet.hall@nexsol.example.com",
				"role": "analyst",
				"company": {
					"id": 12304,
					"subdomain": "nexsol",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 36,
				"name": "Lucy Hill",
				"email": "lucy.hill@nexsol.example.com",
				"role": "manager",
				"company": {
					"id": 12304,
					"subdomain": "nexsol",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 37,
				"name": "Dylan White",
				"email": "dylan.white@nexsol.example.com",
				"role": "support",
				"company": {
					"id": 12304,
					"subdomain": "nexsol",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 38,
				"name": "Eleanor Young",
				"email": "eleanor.young@nexsol.example.com",
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
				}
			},
			{
				"id": 39,
				"name": "Owen Baker",
				"email": "owen.baker@nexsol.example.com",
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
				}
			},
			{
				"id": 40,
				"name": "Hannah Garcia",
				"email": "hannah.garcia@nexsol.example.com",
				"role": "engineer",
				"company": {
					"id": 12304,
					"subdomain": "nexsol",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 41,
				"name": "Elijah Anderson",
				"email": "elijah.anderson@primetech.example.com",
				"role": "admin",
				"company": {
					"id": 12305,
					"subdomain": "primetech",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 42,
				"name": "Christopher Taylor",
				"email": "christopher.taylor@primetech.example.com",
				"role": "support",
				"company": {
					"id": 12305,
					"subdomain": "primetech",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": true,
					"influencer": true
				}
			},
			{
				"id": 43,
				"name": "Harper Jones",
				"email": "harper.jones@primetech.example.com",
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
				}
			},
			{
				"id": 44,
				"name": "Harper Thompson",
				"email": "harper.thompson@primetech.example.com",
				"role": "manager",
				"company": {
					"id": 12305,
					"subdomain": "primetech",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 45,
				"name": "Sofia Clark",
				"email": "sofia.clark@primetech.example.com",
				"role": "analyst",
				"company": {
					"id": 12305,
					"subdomain": "primetech",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 46,
				"name": "Maverick Allen",
				"email": "maverick.allen@primetech.example.com",
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
				}
			},
			{
				"id": 47,
				"name": "Ava Smith",
				"email": "ava.smith@primetech.example.com",
				"role": "manager",
				"company": {
					"id": 12305,
					"subdomain": "primetech",
					"fortune100": false,
					"fortune500": true
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 48,
				"name": "Bella Torres",
				"email": "bella.torres@primetech.example.com",
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
				}
			},
			{
				"id": 49,
				"name": "Avery Williams",
				"email": "avery.williams@primetech.example.com",
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
				}
			},
			{
				"id": 50,
				"name": "Alexander Thomas",
				"email": "alexander.thomas@primetech.example.com",
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
				}
			},
			{
				"id": 51,
				"name": "Layla Young",
				"email": "layla.young@innovaplex.example.com",
				"role": "admin",
				"company": {
					"id": 12306,
					"subdomain": "innovaplex",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 52,
				"name": "Leah Hernandez",
				"email": "leah.hernandez@innovaplex.example.com",
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
				}
			},
			{
				"id": 53,
				"name": "Dylan Wright",
				"email": "dylan.wright@innovaplex.example.com",
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
				}
			},
			{
				"id": 54,
				"name": "Leo Rivera",
				"email": "leo.rivera@innovaplex.example.com",
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
				}
			},
			{
				"id": 55,
				"name": "Emilia Rivera",
				"email": "emilia.rivera@innovaplex.example.com",
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
				}
			},
			{
				"id": 56,
				"name": "Everly Jackson",
				"email": "everly.jackson@innovaplex.example.com",
				"role": "admin",
				"company": {
					"id": 12306,
					"subdomain": "innovaplex",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 57,
				"name": "Hannah Young",
				"email": "hannah.young@innovaplex.example.com",
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
				}
			},
			{
				"id": 58,
				"name": "Anthony Roberts",
				"email": "anthony.roberts@innovaplex.example.com",
				"role": "admin",
				"company": {
					"id": 12306,
					"subdomain": "innovaplex",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 59,
				"name": "Nora Johnson",
				"email": "nora.johnson@innovaplex.example.com",
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
				}
			},
			{
				"id": 60,
				"name": "Ellie Harris",
				"email": "ellie.harris@innovaplex.example.com",
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
				}
			},
			{
				"id": 61,
				"name": "Violet Hill",
				"email": "violet.hill@quantumsoft.example.com",
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
				}
			},
			{
				"id": 62,
				"name": "Mia Harris",
				"email": "mia.harris@quantumsoft.example.com",
				"role": "admin",
				"company": {
					"id": 12307,
					"subdomain": "quantumsoft",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 63,
				"name": "Elijah Perez",
				"email": "elijah.perez@quantumsoft.example.com",
				"role": "manager",
				"company": {
					"id": 12307,
					"subdomain": "quantumsoft",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 64,
				"name": "Owen Green",
				"email": "owen.green@quantumsoft.example.com",
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
				}
			},
			{
				"id": 65,
				"name": "Luna Johnson",
				"email": "luna.johnson@quantumsoft.example.com",
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
				}
			},
			{
				"id": 66,
				"name": "Joseph Jones",
				"email": "joseph.jones@quantumsoft.example.com",
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
				}
			},
			{
				"id": 67,
				"name": "Violet Adams",
				"email": "violet.adams@quantumsoft.example.com",
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
				}
			},
			{
				"id": 68,
				"name": "Lily Davis",
				"email": "lily.davis@quantumsoft.example.com",
				"role": "support",
				"company": {
					"id": 12307,
					"subdomain": "quantumsoft",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 69,
				"name": "Zoe Williams",
				"email": "zoe.williams@quantumsoft.example.com",
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
				}
			},
			{
				"id": 70,
				"name": "Isabella Wilson",
				"email": "isabella.wilson@quantumsoft.example.com",
				"role": "manager",
				"company": {
					"id": 12307,
					"subdomain": "quantumsoft",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 71,
				"name": "Jack Clark",
				"email": "jack.clark@megacorp.example.com",
				"role": "admin",
				"company": {
					"id": 12308,
					"subdomain": "megacorp",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 72,
				"name": "Camila Roberts",
				"email": "camila.roberts@megacorp.example.com",
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
				}
			},
			{
				"id": 73,
				"name": "Hazel Wright",
				"email": "hazel.wright@megacorp.example.com",
				"role": "analyst",
				"company": {
					"id": 12308,
					"subdomain": "megacorp",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 74,
				"name": "Ava Allen",
				"email": "ava.allen@megacorp.example.com",
				"role": "support",
				"company": {
					"id": 12308,
					"subdomain": "megacorp",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 75,
				"name": "Daniel Ramirez",
				"email": "daniel.ramirez@megacorp.example.com",
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
				}
			},
			{
				"id": 76,
				"name": "Leo Torres",
				"email": "leo.torres@megacorp.example.com",
				"role": "manager",
				"company": {
					"id": 12308,
					"subdomain": "megacorp",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 77,
				"name": "Lucas Young",
				"email": "lucas.young@megacorp.example.com",
				"role": "engineer",
				"company": {
					"id": 12308,
					"subdomain": "megacorp",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 78,
				"name": "Thomas Young",
				"email": "thomas.young@megacorp.example.com",
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
				}
			},
			{
				"id": 79,
				"name": "William Wright",
				"email": "william.wright@megacorp.example.com",
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
				}
			},
			{
				"id": 80,
				"name": "Joseph Moore",
				"email": "joseph.moore@megacorp.example.com",
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
				}
			},
			{
				"id": 81,
				"name": "Josiah Nguyen",
				"email": "josiah.nguyen@ultralink.example.com",
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
				}
			},
			{
				"id": 82,
				"name": "Jack Perez",
				"email": "jack.perez@ultralink.example.com",
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
				}
			},
			{
				"id": 83,
				"name": "James Allen",
				"email": "james.allen@ultralink.example.com",
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
				}
			},
			{
				"id": 84,
				"name": "Zoe Harris",
				"email": "zoe.harris@ultralink.example.com",
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
				}
			},
			{
				"id": 85,
				"name": "Isabella Smith",
				"email": "isabella.smith@ultralink.example.com",
				"role": "admin",
				"company": {
					"id": 12309,
					"subdomain": "ultralink",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 86,
				"name": "Leah Roberts",
				"email": "leah.roberts@ultralink.example.com",
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
				}
			},
			{
				"id": 87,
				"name": "Hazel Baker",
				"email": "hazel.baker@ultralink.example.com",
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
				}
			},
			{
				"id": 88,
				"name": "Aurora Torres",
				"email": "aurora.torres@ultralink.example.com",
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
				}
			},
			{
				"id": 89,
				"name": "Michael Young",
				"email": "michael.young@ultralink.example.com",
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
				}
			},
			{
				"id": 90,
				"name": "Emma Harris",
				"email": "emma.harris@ultralink.example.com",
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
				}
			},
			{
				"id": 91,
				"name": "Charles Miller",
				"email": "charles.miller@futuretech.example.com",
				"role": "admin",
				"company": {
					"id": 12310,
					"subdomain": "futuretech",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 92,
				"name": "Maverick Anderson",
				"email": "maverick.anderson@futuretech.example.com",
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
				}
			},
			{
				"id": 93,
				"name": "Lillian Smith",
				"email": "lillian.smith@futuretech.example.com",
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
				}
			},
			{
				"id": 94,
				"name": "Addison Adams",
				"email": "addison.adams@futuretech.example.com",
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
				}
			},
			{
				"id": 95,
				"name": "Layla Robinson",
				"email": "layla.robinson@futuretech.example.com",
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
				}
			},
			{
				"id": 96,
				"name": "Levi Sanchez",
				"email": "levi.sanchez@futuretech.example.com",
				"role": "admin",
				"company": {
					"id": 12310,
					"subdomain": "futuretech",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 97,
				"name": "Sofia Jones",
				"email": "sofia.jones@futuretech.example.com",
				"role": "engineer",
				"company": {
					"id": 12310,
					"subdomain": "futuretech",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				}
			},
			{
				"id": 98,
				"name": "Abigail Wilson",
				"email": "abigail.wilson@futuretech.example.com",
				"role": "engineer",
				"company": {
					"id": 12310,
					"subdomain": "futuretech",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 99,
				"name": "Leo Flores",
				"email": "leo.flores@futuretech.example.com",
				"role": "engineer",
				"company": {
					"id": 12310,
					"subdomain": "futuretech",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": true,
					"influencer": false
				}
			},
			{
				"id": 100,
				"name": "Gabriel Perez",
				"email": "gabriel.perez@futuretech.example.com",
				"role": "manager",
				"company": {
					"id": 12310,
					"subdomain": "futuretech",
					"fortune100": false,
					"fortune500": false
				},
				"groups": {
					"betaTester": false,
					"influencer": false
				}
			}
		];

	}

}
