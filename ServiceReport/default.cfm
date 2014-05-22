<cfquery name="loadGroup" datasource="#application.DSN#">
	SELECT TOP 1 *
	FROM serviceReport
	WHERE imonth = 9
	AND publisherID  = 1
	ORDER BY lname
</cfquery>

<cfquery name="loadPub" datasource="#application.DSN#">
	SELECT *, lname + ', ' + fname as strName
	FROM publisher
	WHERE NOT EXISTS (SELECT * FROM serviceReport 
			WHERE imonth = 9
				AND serviceReport.publisherID  = publisher.publisherID)
	ORDER BY lname
</cfquery>

<cfform type="flash" action="default_action.cfm">
<cfinput type="hidden" name="serviceReportID" value="#loadGroup.serviceReportID#">
<cfoutput>#loadGroup.fname# #loadGroup.lname#</cfoutput>

<cfselect name="publisherID"
	size=1 required="yes" Message="Select Publisher"
	query="loadPub" display="strName" value="publisherID" 
	queryPosition="Below" width="125">
	<option value=2>Choose Publisher</option>
</cfselect>

<cfinput type="submit" name="submit" label="Add Publisher" value="Add Publisher">


</cfform>