<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section
			x-data="g7tzc2.VideoList"
			@hashchange.window="updateFocus()"
			class="ui-content-wrapper">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p class="ui-readable-width">
				These videos provide additional context regarding the various user interfaces within the feature flags playground.
			</p>

			<ul class="u-breathing-room">
				<cfloop array="#videos#" index="video">
					<li>
						<a href="###encodeForUrl( video.id )#">#encodeForHtml( video.title )#</a>
					</li>
				</cfloop>
			</ul>

			<cfloop array="#videos#" index="video">

				<article
					id="#encodeForHtmlAttribute( video.id )#"
					tabindex="-1"
					g7tzc2
					class="ui-readable-width video u-no-inner-margin-y">

					<h2>
						#encodeForHtml( video.title )#
					</h2>

					<p>
						#encodeForHtml( video.description )#
					</p>

					<div g7tzc2 class="video-placeholder">
						<br />
					</div>

					<cfif ( returnToUrl.len() && ( video.id == request.context.videoID ) )>
						<p>
							<a href="#returnToUrl#"><mark>Return to previous page</mark></a> &rarr;
						</p>
					</cfif>

				</article>

			</cfloop>

		</section>

	</cfoutput>
</cfsavecontent>