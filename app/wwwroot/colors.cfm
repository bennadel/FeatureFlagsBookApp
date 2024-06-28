<cfscript>

	colors = [
		{
			index: 1,
			background: "5661ff",
			text: "f1f2ff"
		},
		{
			index: 2,
			background: "65b752",
			text: "f7fff6"
		},
		{
			index: 3,
			background: "f8bf4d",
			text: "0c0c0c"
		},
		{
			index: 4,
			background: "ff4d7f",
			text: "fdfdfd"
		},
		{
			index: 5,
			background: "7f34d6",
			text: "feffff"
		},
		{
			index: 6,
			background: "ffeb0d",
			text: "272727"
		},
		{
			index: 7,
			background: "3bd4d9",
			text: "ffffff"
		},
		{
			index: 8,
			background: "6eff89",
			text: "11323b"
		},
		{
			index: 0,
			background: "ff5b53",
			text: "ffffff"
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