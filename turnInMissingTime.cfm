<cfset idlist = "">
<cfloop list="#form.fieldNames#" index="curlist">
	<cfif findNoCase("_SERVICEREPORTID", curlist)>
		<cfset idlist = listAppend(idList, curlist)>	
	</cfif>
	
</cfloop>

<cfoutput>
	<table>
		<tr>
<td>Name</td> 
<td>Month</td> 
<td>Books</td> 
<td>Brochure</td>  
<td>Hours</td> 
<td>Mags</td> 
<td>RV</td> 
<td>BS</td> 
</tr>
</cfoutput>
<cfset iCount = 1>
<cfloop list="#idList#" index="myList">
<cfoutput>
<tr>
<td>#Evaluate("PUBRow#icount#")#</td> 
<td>#Evaluate("PUBRow#icount#_2")#</td> 
<td>#Evaluate("PUBRow#icount#_3")# </td> 
<td>#Evaluate("PUBRow#icount#_4")#</td>  
<td>#Evaluate("PUBRow#icount#_5")# </td> 
<td>#Evaluate("PUBRow#icount#_6")# </td> 
<td>#Evaluate("PUBRow#icount#_7")# </td> 
<td>#Evaluate("PUBRow#icount#_8")# </td> 
</tr>
</cfoutput>
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

<cfoutput>
	</table>
</cfoutput>


<cfoutput>
	<br><br>
	Missing Time has been updated for your group</cfoutput>
