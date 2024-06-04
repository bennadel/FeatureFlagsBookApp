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

		var id = 0;

		return [
			{
				id: ++id,
				name: "Amanda Harris",
				email: "amanda.harris@innovatek.example.com",
				company: {
					id: 111,
					subdomain: "innovatek",
					fortune100: true,
					fortune500: false
				},
				role: "admin",
				groups: {
					betaTesting: false
				}
			},
			{
				id: ++id,
				name: "Ashley Thomas",
				email: "ashley.thomas@innovatek.example.com",
				company: {
					id: 111,
					subdomain: "innovatek",
					fortune100: true,
					fortune500: false
				},
				role: "engineer",
				groups: {
					betaTesting: false
				}
			},
			{
				id: ++id,
				name: "Charles Davis",
				email: "charles.davis@nexgen.example.com",
				company: {
					id: 222,
					subdomain: "nexgen",
					fortune100: false,
					fortune500: true
				},
				role: "admin",
				groups: {
					betaTesting: false
				}
			},
			{
				id: ++id,
				name: "Christopher Martinez",
				email: "christopher.martinez@nexgen.example.com",
				company: {
					id: 222,
					subdomain: "nexgen",
					fortune100: false,
					fortune500: true
				},
				role: "manager",
				groups: {
					betaTesting: false
				}
			},
			{
				id: ++id,
				name: "David Jones",
				email: "david.jones@ultracorp.example.com",
				company: {
					id: 333,
					subdomain: "ultracorp",
					fortune100: false,
					fortune500: false
				},
				role: "admin",
				groups: {
					betaTesting: false
				}
			},
			{
				id: ++id,
				name: "Elizabeth Lee",
				email: "elizabeth.lee@ultracorp.example.com",
				company: {
					id: 333,
					subdomain: "ultracorp",
					fortune100: false,
					fortune500: false
				},
				role: "manager",
				groups: {
					betaTesting: false
				}
			},
			{
				id: ++id,
				name: "Emily White",
				email: "emily.white@ultracorp.example.com",
				company: {
					id: 333,
					subdomain: "ultracorp",
					fortune100: false,
					fortune500: false
				},
				role: "engineer",
				groups: {
					betaTesting: false
				}
			},
			{
				id: ++id,
				name: "James Smith",
				email: "james.smith@ultracorp.example.com",
				company: {
					id: 333,
					subdomain: "ultracorp",
					fortune100: false,
					fortune500: false
				},
				role: "analyst",
				groups: {
					betaTesting: false
				}
			},
			{
				id: ++id,
				name: "Jennifer Taylor",
				email: "jennifer.taylor@primeworks.example.com",
				company: {
					id: 444,
					subdomain: "primeworks",
					fortune100: false,
					fortune500: false
				},
				role: "admin",
				groups: {
					betaTesting: false
				}
			},
			{
				id: ++id,
				name: "Jessica Anderson",
				email: "jessica.anderson@primeworks.example.com",
				company: {
					id: 444,
					subdomain: "primeworks",
					fortune100: false,
					fortune500: false
				},
				role: "manager",
				groups: {
					betaTesting: false
				}
			},
			{
				id: ++id,
				name: "John Williams",
				email: "john.williams@primeworks.example.com",
				company: {
					id: 444,
					subdomain: "primeworks",
					fortune100: false,
					fortune500: false
				},
				role: "manager",
				groups: {
					betaTesting: false
				}
			},
			{
				id: ++id,
				name: "Joseph Miller",
				email: "joseph.miller@primeworks.example.com",
				company: {
					id: 444,
					subdomain: "primeworks",
					fortune100: false,
					fortune500: false
				},
				role: "engineer",
				groups: {
					betaTesting: false
				}
			},
			{
				id: ++id,
				name: "Melissa Martin",
				email: "melissa.martin@primeworks.example.com",
				company: {
					id: 444,
					subdomain: "primeworks",
					fortune100: false,
					fortune500: false
				},
				role: "engineer",
				groups: {
					betaTesting: false
				}
			},
			{
				id: ++id,
				name: "Michael Johnson",
				email: "michael.johnson@primeworks.example.com",
				company: {
					id: 444,
					subdomain: "primeworks",
					fortune100: false,
					fortune500: false
				},
				role: "engineer",
				groups: {
					betaTesting: false
				}
			},
			{
				id: ++id,
				name: "Nicole Thompson",
				email: "nicole.thompson@primeworks.example.com",
				company: {
					id: 444,
					subdomain: "primeworks",
					fortune100: false,
					fortune500: false
				},
				role: "engineer",
				groups: {
					betaTesting: false
				}
			},
			{
				id: ++id,
				name: "Robert Brown",
				email: "robert.brown@primeworks.example.com",
				company: {
					id: 444,
					subdomain: "primeworks",
					fortune100: false,
					fortune500: false
				},
				role: "analyst",
				groups: {
					betaTesting: false
				}
			},
			{
				id: ++id,
				name: "Sarah Jackson",
				email: "sarah.jackson@primeworks.example.com",
				company: {
					id: 444,
					subdomain: "primeworks",
					fortune100: false,
					fortune500: false
				},
				role: "analyst",
				groups: {
					betaTesting: false
				}
			},
			{
				id: ++id,
				name: "Stephanie Moore",
				email: "stephanie.moore@starline.example.com",
				company: {
					id: 555,
					subdomain: "starline",
					fortune100: false,
					fortune500: true
				},
				role: "admin",
				groups: {
					betaTesting: false
				}
			},
			{
				id: ++id,
				name: "Thomas Rodriguez",
				email: "thomas.rodriguez@starline.example.com",
				company: {
					id: 555,
					subdomain: "starline",
					fortune100: false,
					fortune500: true
				},
				role: "manager",
				groups: {
					betaTesting: false
				}
			},
			{
				id: ++id,
				name: "William Garcia",
				email: "william.garcia@starline.example.com",
				company: {
					id: 555,
					subdomain: "starline",
					fortune100: false,
					fortune500: true
				},
				role: "engineer",
				groups: {
					betaTesting: false
				}
			}
		];

	}

}
