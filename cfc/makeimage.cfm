
	<cfinvoke component="#application.CFCPath#PublisherCard" 
				method="makeImage"
				source="C:\domains\timothyCunningham\PublisherCard\PDF\Adams_Rashard_2009.pdf"
				returnVariable="jpgSource">
				
				<cfdump var="#jpgSource#">
				
				<cfloop list="#jpgSource#" index="jpgPath">
				<cfset jpgLink = replaceNoCase(jpgPath, "C:\domains\timothyCunningham", "..")>
				<cfoutput>
				<a href="#jpgLink#">#jpgLink#</a><br>
				</cfoutput>
				</cfloop>