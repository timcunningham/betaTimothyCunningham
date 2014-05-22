<cfquery name="loadGroups" datasource="#application.DSN#">
	SELECT *
	FROM serviceGroup
	WHERE active=1
	AND serviceGroupID > 9
	ORDER BY groupName
</cfquery>

<cfquery name="getUnsent" datasource="#application.DSN#">
	SELECT TOP 1 imonth, iyear, serviceYear
	FROM serviceReport
	WHERE submittedToBranch=0
</cfquery>


<cfif getUnsent.recordCount GT 0>
	<cfoutput>
	<cfloop query="loadGroups">
	<a href="../emailtimeSheet.cfm?serviceGroupID=#serviceGroupID#&imonth=#getUnsent.imonth#&iyear=#getUnsent.iyear#&serviceYear=#getUnsent.serviceYear#">#groupName#</a><br>

	</cfloop>
	</cfoutput>
<cfelse>
	<cfoutput>You need to init a new month</cfoutput>
</cfif>