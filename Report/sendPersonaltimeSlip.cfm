<cfquery name="email" datasource="#application.DSN#">
	SELECT p.email, p.lname, SR.imonth, SR.iYear, dbo.idate(SR.serviceReportID), datediff(m, dbo.idate(SR.serviceReportID), getDate()), sr.serviceReportID
	FROM publisher P, ServiceReport SR
	WHERE p.publisherID = SR.publisherID
	AND p.email IS NOT NULL
	AND p.email <> ''
	AND datediff(m, dbo.idate(SR.serviceReportID), getDate()) < 7
	AND submittedToBranch  = 0
	AND CARDTRANSFEREDOUT = 0
	AND imonth=11
	ORDER BY P.lname, iyear, imonth
</cfquery>

<cfset sr = createObject("component", "serviceReport.timeSlip")>

<cfloop query="email">
	<cfoutput>#email#, #imonth#/#iyear#  #serviceReportID#<br></cfoutput>
	 <cfset sr.sendPDF(email.serviceReportID)>
</cfloop>