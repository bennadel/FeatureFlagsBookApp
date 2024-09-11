<cfoutput>

	<!doctype html>
	<html lang="en">
	<head>
		<cfmodule template="/content/common/meta.cfm">
		<cfmodule template="/content/common/title.cfm">
		<cfmodule template="/content/common/favicon.cfm">
		<cfmodule template="/content/common/bugsnag.cfm">

		<!--- HTML files dynamically generated by parcel. --->
		<cfinclude template="/wwwroot/client/playground/styles.html" />
		<cfinclude template="/wwwroot/client/playground/scripts.html" />
	</head>
	<body>

		<cfinclude template="./includes/svgSprite.cfm" />

		<div class="m1-shell">
			<header class="m1-shell__header">

				<nav class="m1-nav">
					<a
						href="https://featureflagsbook.com/"
						target="_blank"
						class="m1-nav__item is-logo">

						<span aria-hidden="true" class="m1-nav__icon">
							<svg>#ui.useIcon( "logo" )#</svg>
						</span>
						<span class="m1-nav__label">
							<u>Read Book</u> &rarr;
						</span>
					</a>
					<a
						href="index.cfm?event=playground.home"
						#ui.attrClass({
							"m1-nav__item": true,
							"is-on": ( request.template.activeNavItem == 'features' )
						})#>

						<span aria-hidden="true" class="m1-nav__icon">
							<svg>#ui.useIcon( "feature-flags" )#</svg>
						</span>
						<span class="m1-nav__label">
							<u>Feature Flags</u>
						</span>
					</a>
					<a
						href="index.cfm?event=playground.staging"
						#ui.attrClass({
							"m1-nav__item": true,
							"is-on": ( request.template.activeNavItem == 'staging' )
						})#>

						<span aria-hidden="true" class="m1-nav__icon">
							<svg>#ui.useIcon( "staging" )#</svg>
						</span>
						<span class="m1-nav__label">
							<u>Staging</u>
						</span>
					</a>
					<a
						href="index.cfm?event=playground.users"
						#ui.attrClass({
							"m1-nav__item": true,
							"is-on": ( request.template.activeNavItem == 'users' )
						})#>

						<span aria-hidden="true" class="m1-nav__icon">
							<svg>#ui.useIcon( "users" )#</svg>
						</span>
						<span class="m1-nav__label">
							<u>Users</u>
						</span>
					</a>
					<!---
					<a
						href="index.cfm?event=playground.about"
						#ui.attrClass({
							"m1-nav__item": true,
							"is-on": ( request.template.activeNavItem == 'about' )
						})#>

						<span aria-hidden="true" class="m1-nav__icon">
							<svg>#ui.useIcon( "about" )#</svg>
						</span>
						<span class="m1-nav__label">
							<u>About</u>
						</span>
					</a>
					<a
						href="index.cfm?event=playground.raw"
						#ui.attrClass({
							"m1-nav__item": true,
							"is-on": ( request.template.activeNavItem == 'raw' )
						})#>

						<span aria-hidden="true" class="m1-nav__icon">
							<svg>#ui.useIcon( "raw-json" )#</svg>
						</span>
						<span class="m1-nav__label">
							<u>Raw JSON</u>
						</span>
					</a>
					--->
					<a
						href="index.cfm?event=playground.account"
						#ui.attrClass({
							"m1-nav__item": true,
							"is-on": ( request.template.activeNavItem == 'account' )
						})#>

						<span aria-hidden="true" class="m1-nav__icon">
							<svg>#ui.useIcon( "account" )#</svg>
						</span>
						<span class="m1-nav__label">
							<u>Account</u>
						</span>
					</a>
				</nav>

			</header>
			<main class="m1-shell__main">

				#request.template.primaryContent#

			</main>
		</div>

		<cfmodule template="/content/common/local_debugging.cfm">
	</body>
	</html>

</cfoutput>
