<cfset pdfPath = "C:\Domains\timothyCunningham\">
<cfset pdfFile = "missingtimesheet.pdf">
<cfparam name="serviceGroupID" default="10">
<cfparam name="iMonth" default="12">
<cfparam name="iYear" default="2012">

<cfpdfform source="#pdfPath##pdfFile#" result="resultStruct" action="read"/>

<cfquery name="loadServiceGroup" datasource="#application.DSN#">
	SELECT *
	FROM serviceGroup
	WHERE serviceGroupID = #serviceGroupID#
</cfquery>



<cfquery name="loadGroup" datasource="#application.DSN#">
	SELECT *, lname + ', ' + fname as pubname
	FROM serviceReport 
	WHERE ServiceGroupID = #serviceGroupID# 
	AND hours = 0
	AND  datediff(m, Convert(dateTime, convert(varchar, imonth) + '/1/' +  convert(varchar, iYear)), getDate()) < 7
	AND exists (SELECT * FROM serviceReport SR where sr.imonth = serviceReport.imonth 
				AND sr.iYear = serviceReport.iYear
				AND sr.submittedToBranch = 1 )
	    AND NOT Exists (SELECT * FROM publisher P where serviceReport.publisherID = P.publisherID AND P.cardTransferedOut = 1)
	AND dbo.isActivePublisher(publisherID) > 0
	ORDER BY serviceReportID DESC, lname, fname
</cfquery>


<cfdump var="#loadGroup#">

<cfset destFile = "C:\Domains\timothyCunningham\Group_#loadServiceGroup.groupName#_MissingTime.PDF">
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
		
		<cfif books IS 0>
			<cfset books = "">
		</cfif>
		
		<cfpdfformparam name="PubRow#currentRow#" value="#pubName#">
		<cfpdfformparam name="PubRow#currentRow#_ServiceReportID" value="#ServiceReportID#">
		<cfpdfformparam name="PubRow#currentRow#_2" value="#monthAsString(imonth)#">
		<cfpdfformparam name="PubRow#currentRow#_3" value="#books#">
		<cfpdfformparam name="PubRow#currentRow#_4" value="#brochure#">
		<cfpdfformparam name="PubRow#currentRow#_5" value="#hours#">
		<cfpdfformparam name="PubRow#currentRow#_6" value="#mags#">
		<cfpdfformparam name="PubRow#currentRow#_7" value="#RV#">
		<cfpdfformparam name="PubRow#currentRow#_8" value="#BS#">
		<cfpdfformparam name="PubRow#currentRow#_9" value="#auxilary#">
		<cfpdfformparam name="PubRow#currentRow#_10" value="#regPio#">
		<cfpdfformparam name="PubRow#currentRow#_11" value="#RBC#">

		<!--- <cfpdfformparam name="PubRow#currentRow#" value="#pubName#">
		<cfpdfformparam name="PubRow#currentRow#_ServiceReportID" value="#ServiceReportID#">
		<cfpdfformparam name="PubRow#currentRow#_2" value="#phone#">
		<cfpdfformparam name="PubRow#currentRow#_3" value="">
		<cfpdfformparam name="PubRow#currentRow#_4" value="">
		<cfpdfformparam name="PubRow#currentRow#_5" value="">
		<cfpdfformparam name="PubRow#currentRow#_6" value="">
		<cfpdfformparam name="PubRow#currentRow#_7" value="">
		<cfpdfformparam name="PubRow#currentRow#_8" value="">
		<cfpdfformparam name="PubRow#currentRow#_9" value="">
		<cfpdfformparam name="PubRow#currentRow#_10" value="#regPio#">
		<cfpdfformparam name="PubRow#currentRow#_11" value=""> --->

		<cfpdfformparam name="PubRow#currentRow#_12" value="#remarks#">
		<cfpdfformparam name="serviceGroupID" value="#serviceGroupID#">
	</cfloop>
    
</cfpdfform>

<cfpdf action="read" name="pdf_form" source="#destFile#">

<cfmail to="#loadServiceGroup.groupEmail#"
cc="timcunningham71@gmail.com"
from="tim.cunningham@idminc.com"
subject="#loadServiceGroup.groupName# Group Missing time"
server="mail2.idminc.com"
type="html">

Attached is a PDF, please fill it out and click the button, it will send the time for your group to me.<br>
<br>
Thanks,<br>
Tim Cunningham
	<cfmailparam
	file="Group_#loadServiceGroup.groupName#_MissingTime.PDF"
	type="application/pdf"
	content="#pdf_form#"
	/>
 

</cfmail>