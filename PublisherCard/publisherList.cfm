<cfparam name="cardOrder" default="true">

<cfif cardOrder IS True>
	<cfset sortBy = "ORDER BY SpecialPioneer DESC, Pioneer DESC, elder DESC ,servant DESC,lname,fname">
</cfif>
<cfset sortby="ORDER BY lname, fname">

<cfquery name="loadPub" datasource="#application.DSN#">
	SELECT  *
	FROM Publisher P
	WHERE cardTransferedOut = 0
	#sortby#
</cfquery>

<a href="publisherList.cfm?cardOrder=False">Alphabetical</a> &nbsp;&nbsp;<a href="publisherList.cfm?cardOrder=True">Card Order</a>
<br><br>

<cfoutput>
<table>
<cfloop query="loadPub">
	<tr>
		<td><a href="../publisher/publisher.cfm?publisherID=#publisherID#">Edit</a> &nbsp;
			<a href="viewCards.cfm?publisherID=#publisherID#">#lname#, #fname#</a>
		</td>
		<td><a href="addTime.cfm?publisherID=#publisherID#">Add Time</a>
		</td>
	</tr>
</cfloop>
</table>
</cfoutput>