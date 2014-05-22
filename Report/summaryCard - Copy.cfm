<cfquery name="loadPub" datasource="#application.DSN#">
	SELECT * 
	FROM Publisher P, ServiceReport SR
	WHERE p.email <> ''
	AND SR.publisherID = p.publisherID
	AND SR.hours = 0
	ORDER BY P.lname, P.fname, iyear, imonth
</cfquery>

<cfloop query="loadPub">
	<cfoutput><a href="http://beta.timothycunningham.com/serviceReport/timeSlip.cfc?method=sendPDF&servicereportID=#serviceReportID#">#lname#, #fname# (#imonth# #iYear#)</a><br><br></cfoutput>
</cfloop>
