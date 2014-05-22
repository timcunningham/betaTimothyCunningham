<cfset timeSlip = createObject("component", "serviceReport.timeSlip")>
<cfset turnIn = timeSlip.turnIntime(form)>
<cfabort>


<cfset idlist = "">
<cfloop list="#form.fieldNames#" index="curlist">
	<cfif findNoCase("_SERVICEREPORTID", curlist)>
		<cfset idlist = listAppend(idList, curlist)>	
	</cfif>
	
</cfloop>

<cfset iCount = 1>
<cfloop list="#idList#" index="myList">

	<cfif Evaluate("PUBRow#icount#_5") GT 0>
		<cfquery datasource="#application.DSN#" >
		UPDATE ServiceReport
		SET temp = 0
		-- #Evaluate("PUBRow#icount#")#
		<cfif ISDefined("PUBRow#icount#_3")>
		,books = '#Evaluate("PUBRow#icount#_3")#'
		</cfif>
		<cfif ISDefined("PUBRow#icount#_4")>
		,brochure = '#Evaluate("PUBRow#icount#_4")#'
		</cfif>
		<cfif ISDefined("PUBRow#icount#_5")>
		,hours = '#Evaluate("PUBRow#icount#_5")#'
		</cfif>
		<cfif ISDefined("PUBRow#icount#_6")>
		,mags = '#Evaluate("PUBRow#icount#_6")#'
		</cfif>
		<cfif ISDefined("PUBRow#icount#_7")>
		,RV = '#Evaluate("PUBRow#icount#_7")#'
		</cfif>
		<cfif ISDefined("PUBRow#icount#_8")>
		,BS = '#Evaluate("PUBRow#icount#_8")#'
		</cfif>
		<cfif ISDefined("PUBRow#icount#_9")>
		,aux = '#INT(Evaluate("PUBRow#icount#_9"))#'
		</cfif>
		<cfif ISDefined("PUBRow#icount#_10")>
		,regPioneer= '#INT(Evaluate("PUBRow#icount#_10"))#'
		</cfif>
		<cfif ISDefined("PUBRow#icount#_11")>
		,rbc= '#INT(Evaluate("PUBRow#icount#_11"))#'
		</cfif>
		<cfif ISDefined("PUBRow#icount#_12")>
		,remarks= '#Evaluate("PUBRow#icount#_12")#'
		</cfif>
		WHERE serviceReportID = '#Evaluate("PUBRow#icount#_ServiceReportID")#'
			AND submittedToBranch = 0
		</cfquery>
	</cfif>
	<cfset icount = icount + 1>
</cfloop>


<cfif ISDefined("comments")>
	<cfquery datasource="#application.DSN#" >
		UPDATE serviceGroup
		Set comment='#comments#'
		WHERE serviceGroupID = '#serviceGroupID#'
	</cfquery>


</cfif>

<Cfset iMonth=month("#form.month# 01, #form.year#")>
<cfquery name="loadGroup" datasource="#application.DSN#">
	SELECT * 
	FROM serviceGroup
	WHERE serviceGroupID = #serviceGroupID#
</cfquery>

<cfhttp url="http://beta.timothycunningham.com/Report/serviceGroupReport.cfm?serviceGroupID=#serviceGroupID#&imonth=#iMonth#&iYear=#form.Year#" result="strHTML">


<cfmail to="#loadGroup.groupEmail#"
cc="timcunningham71@gmail.com"
from="timcunningham71@gmail.com"
subject="Report for #loadGroup.groupName# Received for #form.month# #form.Year#"
server="mail2.idminc.com"
type="html">
#strHTML.filecontent#
 </cfmail>
 

 <cfheader name="Content-Disposition" value="inline; filename=missingTime.pdf">
<cfdocument format="PDF">
<cfoutput>#strHTML.filecontent#</cfoutput>
</cfdocument>

