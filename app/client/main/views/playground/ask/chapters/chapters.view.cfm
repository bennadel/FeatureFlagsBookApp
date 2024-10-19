<cfsavecontent variable="request.template.primaryContent">
	<cfoutput>

		<section class="ui-content-wrapper">

			<h1>
				#encodeForHtml( title )#
			</h1>

			<p class="ui-readable-width">
				If you have a question about feature flags, product development, or the combination thereof, feel free to <a href="https://www.linkedin.com/in/bennadel/" target="_blank">connect with me on LinkedIn</a>. Or, if you have a question about a chapter in <a href="https://featureflagsbook.com/" target="_blank">the book</a>, I've created a blog post for each chapter so that the content can be discussed within the comments.
			</p>

			<h2>
				Chapter Discussions for Feature Flags Book
			</h2>

			<ul class="u-breathing-room">
				<cfloop array="#chapters#" index="chapter">
					<li>
						<a href="#encodeForHtmlAttribute( chapter.href )#" target="_blank">#encodeForHtml( chapter.title )#</a>
					</li>
				</cfloop>
			</ul>

		</section>

	</cfoutput>
</cfsavecontent>
