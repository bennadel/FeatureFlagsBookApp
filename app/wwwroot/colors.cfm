<cfscript>

	colors = [
		{
			index: 1,
			background: "82ede8",
			text: "211bae"
		},
		{
			index: 2,
			background: "65b752",
			text: "e9ff72"
		},
		{
			index: 3,
			background: "f3c677",
			text: "000cb4"
		},
		{
			index: 4,
			background: "ff4d80",
			text: "0a03b1"
		},
		{
			index: 5,
			background: "274c77",
			text: "dfecff"
		},
		{
			index: 6,
			background: "6a3d9a",
			text: "ff9d9d"
		},
		{
			index: 7,
			background: "f7aef8",
			text: "a4005f"
		},
		{
			index: 8,
			background: "b9ff47",
			text: "11323b"
		},
		{
			index: 0,
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

	<cfloop array="#colors#" index="color">
		<cfoutput>

			.variant-#color.index# {
				background-color: ###color.background# ;
				color: ###color.text# ;
			}
	
		</cfoutput>
	</cfloop>
</style>
<cfoutput>

	<div>
		<cfloop array="#colors#" index="color">

			<span class="variant-#color.index#">
				#color.background#
			</span>

		</cfloop>

		<!--- Plain text version. --->
		<cfloop index="i" from="1" to="100">

			<cfset color = randColor() />

			<span class="variant-#color.index#">
				#color.background#
			</span>

		</cfloop>

		<!--- Underlined text version. --->
		<cfloop index="i" from="1" to="100">

			<cfset color = randColor() />

			<span class="variant-#color.index#" style="text-decoration: underline ;">
				#color.background#
			</span>

		</cfloop>
	</div>

</cfoutput>