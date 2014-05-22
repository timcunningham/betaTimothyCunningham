<cfset pdfPath = "C:\Domains\timothyCunningham\">
<cfset pdfFile = "timesheet.pdf">
<cfparam name="serviceGroupID" default="13">
<cfparam name="iMonth" default="10">


<cfpdfform source="#pdfPath##pdfFile#" result="resultStruct" action="read"/>

<cfquery name="loadServiceGroup" datasource="#application.DSN#">
	SELECT *
	FROM serviceGroup
	WHERE serviceGroupID = #serviceGroupID#
</cfquery>



<cfquery name="loadGroup" datasource="#application.DSN#">
	SELECT *, lname + ', ' + fname as pubname
	FROM serviceReport
	WHERE serviceGroupID = #serviceGroupID#
	AND iMonth = #iMonth#
</cfquery>




<cfpdfform action="populate" source="#pdfPath##pdfFile#">
    <cfpdfformparam name="GroupInfo" value="#loadServiceGroup.groupName#">
    <cfpdfformparam name="month" value="#MonthAsString(loadGroup.imonth)#">
    <cfpdfformparam name="year" value="#loadGroup.iYear#">
    <cfloop query="loadGroup">
		<cfquery name="loadpub" datasource="#application.DSN#">
			SELECT *
			FROM publisher
			WHERE publisherID = #publisherID#
		</cfquery>
		<cfset phone = loadPub.telephone>
		<cfif phone IS "">
			<cfset phone = loadPub.mobile>
		</cfif>
		<cfset regPio = "">
		<cfif regPioneer IS true>
			<cfset regPio = "Yes">
		</cfif>
		
		<cfpdfformparam name="PubRow#currentRow#" value="#pubName#">
		<cfpdfformparam name="PubRow#currentRow#_ServiceReportID" value="#ServiceReportID#">
		<cfpdfformparam name="PubRow#currentRow#_2" value="#phone#">
		<cfpdfformparam name="PubRow#currentRow#_10" value="#regPio#">
		<cfpdfformparam name="serviceGroupID" value="#serviceGroupID#">
	</cfloop>
    
</cfpdfform>