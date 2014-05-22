<cfset pdfPath = "C:\Domains\timothyCunningham\">
<cfset pdfFile = "timesheet.pdf">
<cfparam name="serviceGroupID" default="15">
<cfparam name="iMonth" default="11">


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



<cfset destFile = "C:\Domains\timothyCunningham\#MonthAsString(loadGroup.imonth)#_2009_Group_#loadServiceGroup.groupName#_report.PDF">
<cfpdfform action="populate" source="#pdfPath##pdfFile#" destination="#destFile#" overwrite="true">
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
		
		<cfset auxilary = "">
		<cfif aux IS True>
			<cfset auxilary = "Yes">
		</cfif>
		
		<cfpdfformparam name="PubRow#currentRow#" value="#pubName#">
		<cfpdfformparam name="PubRow#currentRow#_ServiceReportID" value="#ServiceReportID#">
		<cfpdfformparam name="PubRow#currentRow#_2" value="#phone#">
		<cfpdfformparam name="PubRow#currentRow#_3" value="#books#">
		<cfpdfformparam name="PubRow#currentRow#_4" value="#brochure#">
		<cfpdfformparam name="PubRow#currentRow#_5" value="#hours#">
		<cfpdfformparam name="PubRow#currentRow#_6" value="#mags#">
		<cfpdfformparam name="PubRow#currentRow#_7" value="#RV#">
		<cfpdfformparam name="PubRow#currentRow#_8" value="#BS#">
		<cfpdfformparam name="PubRow#currentRow#_9" value="#auxilary#">
		<cfpdfformparam name="PubRow#currentRow#_10" value="#regPio#">
		<cfpdfformparam name="PubRow#currentRow#_11" value="#RBC#">
		<cfpdfformparam name="PubRow#currentRow#_12" value="#remarks#">
		<cfpdfformparam name="serviceGroupID" value="#serviceGroupID#">
	</cfloop>
    
</cfpdfform>

<cfpdf action="read" name="pdf_form" source="#destFile#">

<cfmail to="#loadServiceGroup.groupEmail#"
cc="timcunningham71@gmail.com"
from="timcunningham71@gmail.com"
subject="#MonthAsString(loadGroup.imonth)# Report for #loadServiceGroup.groupName#"
server="mail2.idminc.com"
type="html">

Attached is a PDF is the time reported for your group.  If you need to make corrections or have additional time to report, you may resubmit the attached PDF.
Thanks,<br>
Tim
	<cfmailparam
	file="#MonthAsString(loadGroup.imonth)#_2009_Group_#loadServiceGroup.groupName#_report.PDF"
	type="application/pdf"
	content="#pdf_form#"
	/>
 

</cfmail>

