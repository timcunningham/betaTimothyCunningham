<cfquery name="loadGroup" datasource="#application.DSN#">
	SELECT *
	FROM serviceGroup
	WHERE serviceGroupID = #serviceGroupID#
	AND serviceGroupID > 9
	ORDER BY groupName
</cfquery>

<cfquery name="loadPubs" datasource="#application.DSN#">
	SELECT publisherID, fname, lname
	FROM publisher
	WHERE serviceGroupID = #serviceGroupID#
	ORDER BY lname
</cfquery>


<cfquery name="loadALLPubs" datasource="#application.DSN#">
	SELECT publisherID, fname, lname, lname + ', ' + fname as strName
	FROM publisher
	WHERE serviceGroupID = 1
	ORDER BY lname
</cfquery>




<cfoutput>
<h1>#loadGroup.groupName#</h1><br>
<cfloop query="loadPubs">
	#Lname#, #fname#<br>
</cfloop>
<cfform action="default_action.cfm" format="flash">

<cfinput type="Hidden" value="#serviceGroupID#"  name="serviceGroupID">

<cfselect name="loadALLPubs"
	size=1 required="yes" Message="Select a Publisher"
	query="loadALLPubs" display="strName" value="publisherID" group="publisherID"
	queryPosition="Below" width="125">
	<option value=1>Choose Publisher</option>
</cfselect>
<cfinput type="submit" name="submit" label="Add Publisher" value="Add Publisher">


</cfform>

</cfoutput>

