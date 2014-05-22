<cfset arrayPublisherListID = arraynew(1)>
<cfset arrayServiceYear = arrayNew(1)>

<cfset arrayPublisherListID[1] = 71>
<cfset arrayPublisherListID[2] = 73>

<cfset arrayServiceYear[1] = "2014">
<cfset arrayServiceYear[2] = "2014">

<cfset filename = "TimP">
<!---
<cfset card = createObject("component", "cfc.publisherCard")>
<cfset mycard = card.get2CardPage(arrayPublisherListID, arrayServiceYear, filename, 1)>

<Cfdump var="#mycard#"> --->



<cfquery name="loadPub" datasource="#application.DSN#">
	SELECT  publisherID, fname, lname
	FROM publisher
	WHERE cardTransferedOut = 0
	--AND (SELECT sum(hours) FROM serviceReport SR WHERE sr.publisherID = publisher.publisherID AND serviceYear=2012) > 0
	ORDER BY lname,fname
</cfquery>

<cfset arrayAllPubID = arrayNew(1)>
<cfset arrayAllNames = arrayNew(1)>

<cfloop query="loadPub">
	<cfset arrayAllPubID[currentRow] = publisherID>
	<cfset arrayAllNames[currentRow] = "#lname#-#fname#">
</cfloop>

<cfset arrayServiceYear[1] = "2013">
<cfset arrayServiceYear[2] = "2013">
<cfset card = createObject("component", "cfc.publisherCard")>

<cfset fileList ="">
<cfloop from=1 to="#arrayLen(arrayAllPUbID)#" index=i step=2>
	<cfset arrayPublisherListID[1] = arrayAllPUBID[i]>
	<cftry>
	<cfset arrayPublisherListID[2] = arrayAllPUBID[i+1]>
	<cfcatch>
		<cfset arrayPublisherListID[2] = arrayAllPUBID[i]>
	</cfcatch>
	</cftry>
	
	<cftry>
	<cfset filename = arrayAllNames[i] & "--" & arrayAllNames[i+1]>
	<cfcatch>
		<cfset filename = arrayAllNames[i] & "--" & arrayAllNames[i]>
	</cfcatch>
	</cftry>
	<!---
	<cfdump var="#arrayPublisherListID#">
	<cfoutput>filename: #filename#<br></cfoutput>
	--->
	<cfoutput><a href="http://beta.timothycunningham.com/publisherCard\pdf2page\#filename#.pdf">#filename#.pdf</a><br><br></cfoutput>
	<cfset mycard = card.get2CardPage(arrayPublisherListID, arrayServiceYear, filename, 1)>
	<cfset fileList = listAppend(fileList, mycard)>
</cfloop>


<cfpdf action="merge" source="#fileList#" destination="C:\Domains\timothycunningham\publisherCard\pdf2page\all2012.pdf" overwrite="true">



<cfoutput><a href="http://beta.timothycunningham.com/publisherCard\pdf2page\all2012.pdf">all2012.pdf</a></cfoutput>
