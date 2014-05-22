<cfdump var="#form#">

<cfquery  datasource="#application.DSN#">
	UPDATE serviceReport
	SET publisherID = #publisherID#
	WHERE serviceReportID = #serviceReportID#
</cfquery>

<cflocation url="default.cfm">