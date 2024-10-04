<cfoutput>

	<!doctype html>
	<html lang="en">
	<head>
		<cfmodule template="/content/common/meta.cfm">
		<cfmodule template="/content/common/title.cfm">
		<cfmodule template="/content/common/favicon.cfm">
		<cfmodule template="/content/common/bugsnag.cfm">

		<!--- HTML files dynamically generated by parcel. --->
		<cfinclude template="/wwwroot/client/main.html" />
	</head>
	<body x-data="m2f8ql7.AppShell" m-2f8ql7 class="body">

		<cfmodule template="./tags/svgSprite.cfm">

		<a href="##main-content-anchor" @click="focusMain()" m-2f8ql7 class="skip-to-main">
			Skip to main content
		</a>

		<div m-2f8ql7 class="shell">
			<header m-2f8ql7 class="shell__header">

				<nav m-2f8ql7 class="nav">
					<a
						href="https://featureflagsbook.com/"
						target="_blank"
						m-2f8ql7
						class="nav__item is-logo">

						<span m-2f8ql7 aria-hidden="true" class="nav__icon">
							<cfmodule
								template="./tags/icon.cfm"
								type="logo">
							</cfmodule>
						</span>
						<span m-2f8ql7 class="nav__label">
							<u>Read Book</u> &rarr;
						</span>
					</a>
					<a
						href="index.cfm?event=playground.features"
						m-2f8ql7
						#ui.attrClass({
							"nav__item": true,
							"is-on": ( request.template.activeNavItem == 'features' )
						})#>

						<span aria-hidden="true" m-2f8ql7 class="nav__icon">
							<cfmodule
								template="./tags/icon.cfm"
								type="feature-flags">
							</cfmodule>
						</span>
						<span m-2f8ql7 class="nav__label">
							<u>Feature Flags</u>
						</span>
					</a>
					<a
						href="index.cfm?event=playground.staging"
						m-2f8ql7
						#ui.attrClass({
							"nav__item": true,
							"is-on": ( request.template.activeNavItem == 'staging' )
						})#>

						<span aria-hidden="true" m-2f8ql7 class="nav__icon">
							<cfmodule
								template="./tags/icon.cfm"
								type="staging">
							</cfmodule>
						</span>
						<span m-2f8ql7 class="nav__label">
							<u>Staging</u>
						</span>
					</a>
					<a
						href="index.cfm?event=playground.users"
						m-2f8ql7
						#ui.attrClass({
							"nav__item": true,
							"is-on": ( request.template.activeNavItem == 'users' )
						})#>

						<span aria-hidden="true" m-2f8ql7 class="nav__icon">
							<cfmodule
								template="./tags/icon.cfm"
								type="users">
							</cfmodule>
						</span>
						<span m-2f8ql7 class="nav__label">
							<u>Users</u>
						</span>
					</a>
					<a
						href="index.cfm?event=playground.raw"
						m-2f8ql7
						#ui.attrClass({
							"nav__item": true,
							"is-on": ( request.template.activeNavItem == 'raw' )
						})#>

						<span aria-hidden="true" m-2f8ql7 class="nav__icon">
							<cfmodule
								template="./tags/icon.cfm"
								type="raw-json">
							</cfmodule>
						</span>
						<span m-2f8ql7 class="nav__label">
							<u>Raw JSON</u>
						</span>
					</a>
					<a
						href="index.cfm?event=playground.account"
						m-2f8ql7
						#ui.attrClass({
							"nav__item": true,
							"is-on": ( request.template.activeNavItem == 'account' )
						})#>

						<span aria-hidden="true" m-2f8ql7 class="nav__icon">
							<cfmodule
								template="./tags/icon.cfm"
								type="account">
							</cfmodule>
						</span>
						<span m-2f8ql7 class="nav__label">
							<u>Account</u>
						</span>
					</a>
				</nav>

				<div m-2f8ql7 class="video-link">
					Video TBD
				</div>

			</header>
			<main id="main-content-anchor" x-ref="main" tabindex="-1" m-2f8ql7 class="shell__main">

				#request.template.primaryContent#

			</main>
		</div>

		<cfmodule template="/content/common/local_debugging.cfm">
	</body>
	</html>

</cfoutput>
