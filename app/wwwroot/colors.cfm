<cfscript>

	colors = [
		{
			background: "82ede8",
			text: "3220ff"
		},
		{
			background: "65b752",
			text: "f8ff4f"
		},
		{
			background: "f3c677",
			text: "000cb4"
		},
		{
			background: "ff4d80",
			text: "0a03b1"
		},
		{
			background: "274c77",
			text: "dfecff"
		},
		{
			background: "6a5d7b",
			text: "ffe42a"
		},
		{
			background: "f7aef8",
			text: "a4005f"
		},
		{
			background: "b9ff47",
			text: "11323b"
		},
		{
			background: "841b1b",
			text: "ffd5d5"
		}
	];

	/**
	* I return a random color object.
	*/
	public struct function randColor() {

		return colors[ randRange( 1, arrayLen( colors ), "sha1prng" ) ];

	}

</cfscript>
<style>
	body {
		font-family: monospace ;
		font-size: 20px ;
		line-height: 1.4 ;
	}
	div {
		display: flex ;
		flex-wrap: wrap ;
		gap: 1px ;
	}
	div span {
		flex: 1 1 auto ;
		padding: 30px 60px ;
	}
</style>
<cfoutput>

	<div>
		<cfloop array="#colors#" index="color">

			<span style="background: ###color.background# ; color: ###color.text# ;">
				#color.background#
			</span>

		</cfloop>

		<cfloop index="i" from="1" to="100">

			<cfset color = randColor() />

			<span style="background: ###color.background# ; color: ###color.text# ;">
				#color.background#
			</span>

		</cfloop>

		<cfloop index="i" from="1" to="100">

			<cfset color = randColor() />

			<span style="background: ###color.background# ; color: ###color.text# ; text-decoration: underline ;">
				#color.background#
			</span>

		</cfloop>
	</div>

</cfoutput>