<cfoutput>

	<!doctype html>
	<html lang="en">
	<head>
		<cfmodule template="/client/main/tags/meta.cfm">
		<cfmodule template="/client/main/tags/title.cfm">
		<cfmodule template="/client/main/tags/favicon.cfm">
		<cfmodule template="/client/main/tags/bugsnag.cfm">

		<!--- HTML files dynamically generated by Parcel. --->
		<cfinclude template="/wwwroot/client/main/main.html" />
	</head>
	<body x-data="m2f8ql7.AppShell" m-2f8ql7 class="body">

		<cfmodule template="/client/main/tags/svgSprite.cfm">

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
								template="/client/main/tags/icon.cfm"
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
								template="/client/main/tags/icon.cfm"
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
								template="/client/main/tags/icon.cfm"
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
								template="/client/main/tags/icon.cfm"
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
								template="/client/main/tags/icon.cfm"
								type="raw-json">
							</cfmodule>
						</span>
						<span m-2f8ql7 class="nav__label">
							<u>Raw JSON</u>
						</span>
					</a>
					<a
						href="index.cfm?event=playground.ask"
						m-2f8ql7
						#ui.attrClass({
							"nav__item": true,
							"is-on": ( request.template.activeNavItem == 'ask' )
						})#>

						<span aria-hidden="true" m-2f8ql7 class="nav__icon">
							<cfmodule
								template="/client/main/tags/icon.cfm"
								type="ask">
							</cfmodule>
						</span>
						<span m-2f8ql7 class="nav__label">
							<u>Ask Question</u>
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
								template="/client/main/tags/icon.cfm"
								type="account">
							</cfmodule>
						</span>
						<span m-2f8ql7 class="nav__label">
							<u>Account</u>
						</span>
					</a>
				</nav>

				<cfif request.template.video.len()>
					<a href="/index.cfm?event=playground.videos&videoID=#encodeForUrl( request.template.video )#&returnTo=#encodeForUrl( internalUrl )####encodeForUrl( request.template.video )#" m-2f8ql7 class="video-link">
						Video TBD

						<span m-2f8ql7 class="video-link__temp">
							(#encodeForHtml( request.template.video )#)
						</span>
					</a>
				</cfif>

			</header>
			<main id="main-content-anchor" x-ref="main" tabindex="-1" m-2f8ql7 class="shell__main">

				#request.template.primaryContent#

			</main>
		</div>

		<cfmodule template="/client/main/tags/localDebugging.cfm">
	</body>
	</html>

</cfoutput>
