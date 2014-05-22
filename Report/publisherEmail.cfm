<cfquery name="all" datasource="#application.DSN#">
	SELECT * 
	FROM publisher 
	WHERE cardTransferedOut = 0
	ORDER BY lname, fname
</cfquery>

<cfoutput>
<table>
<cfloop query="all">
<form method="post" id="pub_#publisherID#" action="publisherEmail_action.cfm">
<tr><td>#lname#, #fname#</td><td><input name="email" value="#email#" maxlength="100" size="100"></td>
<td><input type="submit" id="submit_#publisherID#">
</tr>
<input type="hidden" name="publisherID" value="#publisherID#">

</form>
</cfloop>
</table>
</cfoutput>