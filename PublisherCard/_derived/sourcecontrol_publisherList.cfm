<cfquery name="loadPub" datasource="#application.DSN#">
	SELECT  *
	FROM Publisher P
	ORDER BY lname
</cfquery>


<cfoutput>
<table>
<cfloop query="loadPub">
	<tr>
		<td>
			<a href="viewCards.cfm?publisherID=#publisherID#">#lname#, #fname#</a>
		</td>
		<td><a href="addTime.cfm?publisherID=#publisherID#">Add Time</a>
		</td>
	</tr>
</cfloop>
</table>
</cfoutput>