<cfsavecontent variable="request.template.primaryContent">
	<style type="text/css">

		.grid {
			border-collapse: collapse ;
			border-spacing: 0 ;
			width: 100% ;
		}
		.grid th,
		.grid td {
			border-bottom: 1px solid #cccccc ;
			padding: 7px 10px ;
			text-align: left ;
			white-space: nowrap ;
		}
		.grid th {
			border-bottom-width: 2px ;
		}
		.grid th.sticky {
			background-color: #ffffff ;
			padding: 10px ;
			position: sticky ;
			top: -1px ;
			z-index: 2 ;
		}
		.grid .col-group {
			border: 1px dashed #cccccc ;
			border-bottom: 2px solid #cccccc ;
			padding: 10px ;
			text-align: center ;
		}
		.grid .row-group {
			padding: 20px 20px ;
			text-align: center ;
		}

		.grid tbody tr:hover th,
		.grid tbody tr:hover td {
			background-color: #f0f0f0 ;
		}
		.grid .sorter {
			cursor: pointer ;
			user-select: none ;
		}

		.diminish {
			opacity: 0.3 ;
		}
		.highlight {
			background-color: #fff59a ;
		}

	</style>
	<cfoutput>

		<section class="content-wrapper u-collapse-margin">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p class="ui-readable-width">
				The following users are here to demonstrate how feature flag targeting affects variant allocation. I've purposely generated 100 users so that every 1% of additional distribution will map (roughly) to 1 additional user.
			</p>

			<p class="ui-readable-width">
				I've also created #numberFormat( authUsers.len() )# users <mark>based on <em>your</em> email address</mark> that are part of a company with the subdomain "<strong>devteam</strong>":
			</p>

			<ul class="breathing-room">
				<cfloop array="#authUsers#" index="user">
					<li>
						<span class="ui-tag">#encodeForHtml( user.role )#</span>
						&rarr;
						<a href="/index.cfm?event=playground.staging.user&userID=#encodeForUrl( user.id )#">#encodeForHtml( user.email )#</a>
					</li>
				</cfloop>
			</ul>

			<table id="grid" class="grid">
			<thead>
				<tr>
					<th colspan="3" class="col-group">
						User
					</th>
					<th colspan="4" class="col-group">
						Company
					</th>
					<th colspan="2" class="col-group">
						Groups
					</th>
				</tr>
				<tr>
					<!-- User. -->
					<th class="sticky">
						<a href="/index.cfm?event=playground.users&sortOn=user.id##grid" class="sorter">
							ID
						</a>
					</th>
					<th class="sticky">
						<a href="/index.cfm?event=playground.users&sortOn=user.email##grid" class="sorter">
							Email
						</a>
					</th>
					<th class="sticky">
						<a href="/index.cfm?event=playground.users&sortOn=user.role##grid" class="sorter">
							Role
						</a>
					</th>
					<!-- Company. -->
					<th class="sticky">
						<a href="/index.cfm?event=playground.users&sortOn=user.company.id##grid" class="sorter">
							ID
						</a>
					</th>
					<th class="sticky">
						<a href="/index.cfm?event=playground.users&sortOn=user.company.subdomain##grid" class="sorter">
							Subdomain
						</a>
					</th>
					<th class="sticky">
						<a href="/index.cfm?event=playground.users&sortOn=user.company.fortune100##grid" class="sorter">
							Fortune100
						</a>
					</th>
					<th class="sticky">
						<a href="/index.cfm?event=playground.users&sortOn=user.company.fortune500##grid" class="sorter">
							Fortune500
						</a>
					</th>
					<!-- Groups. -->
					<th class="sticky">
						<a href="/index.cfm?event=playground.users&sortOn=user.groups.betaTester##grid" class="sorter">
							BetaTester
						</a>
					</th>
					<th class="sticky">
						<a href="/index.cfm?event=playground.users&sortOn=user.groups.influencer##grid" class="sorter">
							Influencer
						</a>
					</th>
				</tr>
			</thead>
			<cfloop array="#groups#" index="group">
				<tbody>
					<tr>
						<th colspan="9" class="row-group">
							#encodeForHtml( group.name )#
							(#numberFormat( group.users.len() )#)
						</th>
					</tr>
					<cfloop array="#group.users#" index="user">
						<tr>
							<!-- User. -->
							<td #ui.attrClass({ highlight: ( url.sortOn == 'user.id' ) })#>
								<a href="/index.cfm?event=playground.staging.user&userID=#encodeForUrl( user.id )#">#encodeForHtml( user.id )#</a>
							</td>
							<td #ui.attrClass({ highlight: ( url.sortOn == 'user.email' ) })#>
								<a href="/index.cfm?event=playground.staging.user&userID=#encodeForUrl( user.id )#"><span class="diminish">#encodeForHtml( user.emailUser )#</span>#encodeForHtml( user.emailDomain )#</a>
							</td>
							<td #ui.attrClass({ highlight: ( url.sortOn == 'user.role' ) })#>
								#encodeForHtml( user.role )#
							</td>
							<!-- Company. -->
							<td #ui.attrClass({ highlight: ( url.sortOn == 'user.company.id' ) })#>
								#encodeForHtml( user.company.id )#
							</td>
							<td #ui.attrClass({ highlight: ( url.sortOn == 'user.company.subdomain' ) })#>
								#encodeForHtml( user.company.subdomain )#
							</td>
							<td #ui.attrClass({ highlight: ( url.sortOn == 'user.company.fortune100' ) })#>
								#yesNoFormat( user.company.fortune100 )#
							</td>
							<td #ui.attrClass({ highlight: ( url.sortOn == 'user.company.fortune500' ) })#>
								#yesNoFormat( user.company.fortune500 )#
							</td>
							<!-- Groups. -->
							<td #ui.attrClass({ highlight: ( url.sortOn == 'user.groups.betaTester' ) })#>
								#yesNoFormat( user.groups.betaTester )#
							</td>
							<td #ui.attrClass({ highlight: ( url.sortOn == 'user.groups.influencer' ) })#>
								#yesNoFormat( user.groups.influencer )#
							</td>
						</tr>

					</cfloop>
				</tbody>
			</cfloop>
			</table>

		</section>

	</cfoutput>
</cfsavecontent>
