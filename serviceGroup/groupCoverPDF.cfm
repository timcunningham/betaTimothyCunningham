<cfhttp url="http://beta.timothycunningham.com/serviceGroup/groupCoverSheet.cfm" >

<cfdocument format="pdf">
	<cfoutput>#cfhttp.filecontent#</cfoutput>
</cfdocument>