<cfparam name="publisherID" default =2>
<cfparam name="serviceYear" default="2013">
<cfset thisYear = datepart("yyyy", now())>
<Cfset lastMonth = datepart("m", now()) - 1>

<cfif lastmonth  IS 0>
	<cfset thisYear = thisYear - 1>
	<cfset lastMonth = 12>
</cfif>

<cfparam name="iYear" default="#thisYear#">
<cfparam name="imonth" default="#lastMonth#">


<cfquery name="loadPub" datasource="#application.DSN#">
	SELECT TOP 1 *
	FROM Publisher P
	WHERE publisherID = #publisherID#
</cfquery>
<cfdump var="#loadPub#">


<cfquery name="loadReport" datasource="#application.DSN#">
	SELECT *
	FROM ServiceReport
	WHERE iYear = '#iYear#'
		AND imonth = '#imonth#'
		aND  publisherID = #publisherID#
</cfquery>

<cfquery name="loadMissing" datasource="#application.DSN#">
	SELECT *
	FROM ServiceReport
	WHERE publisherID = #publisherID#
	 and submittedToBranch=0 
	 AND hours = 0
</cfquery>





<cfif loadReport.recordCount GT 0>
	<cfloop query="loadReport">
		<cfset iBooks = books>
		<cfset iBrochure = brochure>
		<cfset iHours = hours>
		<cfset iMags = mags>
		<cfset iRV = RV>
		<cfset iBS = bs>
		<cfset iRemarks = remarks>
		<cfset iRBC = rbc>
		<cfset xYear = iYear>
		<cfset iAux = aux>
		<cfset iRegPioneer = regPioneer>
		<cfset iUnbapt = unbapt>
		<cfset actionType = "Update">
		<cfset iMinute = minute>
		<cfset iSpecialPioneer = specialPioneer>
		<cfset isubmittedToBranch = submittedToBranch>
	</cfloop>
<cfelse>
	<cfset iBooks = "">
	<cfset iBrochure = "">
	<cfset iHours = "">
	<cfset iMags = "">
	<cfset iRV = "">
	<cfset iBS = "">
	<cfset iRemarks = "">
	<cfset iRBC = "">
	<cfset iAux = 0>
	<cfset iRegPioneer = "#loadPub.Pioneer#">
	<cfset iUnbapt = 0>
	<cfset xYear = iYear>
	<cfset iMinute = 0>
	<cfset actionType = "Insert">
	<cfset iSpecialPioneer = 0>
	<cfset isubmittedToBranch = 0>
</cfif>

<cfoutput>
<form action="addTime_action.cfm" method=Post>
<input type="hidden" name=actionType value="#actionType#">
<input type="hidden" name=publisherID value="#loadPub.publisherID#">
<input type="hidden" name=fname value="#loadPub.fname#">
<input type="hidden" name=lname value="#loadPub.lname#">
<input type="hidden" name=ServiceGroupID value="#loadPub.ServiceGroupID#">



<table>
<tr>
	<td colspan="2">
	<center><h1>#loadPub.fname# #loadPub.lname#
	<br>#imonth# 
	</h1>
	#actionType#
	</center>
	</td>

</tr>

<tr>
	<td>ServiceYear</td>
	<td>
		<input type="textbox" name="serviceYear" size=25 autocomplete="off" maxlength=25 value="#serviceYear#">
	</td>
</tr>

<tr>
	<td>Calendar Year</td>
	<td>
		<input type="textbox" name="iyear" size=25 autocomplete="off" maxlength=25 value="#xyear#">
	</td>
</tr>

<tr>
	<td>Month</td>
	<td>
		<input type="textbox" name="imonth" size=25 autocomplete="off" maxlength=25 value="#imonth#">
	</td>
</tr>

<tr>
	<td>Books</td>
	<td>
		<input type="textbox" name="Books" size=25 autocomplete="off" maxlength=25 value="#iBooks#">
	</td>
</tr>

<tr>
	<td>Brochure</td>
	<td>
		<input type="textbox" name="Brochure" size=25 autocomplete="off" maxlength=25 value="#iBrochure#">
	</td>
</tr>


<tr>
	<td>Hours</td>
	<td>
		<input type="textbox" name="Hours" size=25 autocomplete="off" maxlength=25 value="#iHours#">
	</td>
</tr>

<tr>
	<td>Mags</td>
	<td>
		<input type="textbox" name="Mags" size=25 autocomplete="off" maxlength=25 value="#iMags#">
	</td>
</tr>

<tr>
	<td>RV</td>
	<td>
		<input type="textbox" name="RV" size=25 autocomplete="off" maxlength=25 value="#iRV#">
	</td>
</tr>

<tr>
	<td>BS</td>
	<td>
		<input type="textbox" name="BS" size=25 autocomplete="off" maxlength=25 value="#iBS#">
	</td>
</tr>

<tr>
	<td>RBC</td>
	<td>
		<input type="textbox" name="RBC" size=25 autocomplete="off" maxlength=25 value="#iRBC#">
	</td>
</tr>
<tr>
	<td>Aux</td>
	<td>
		<input type="textbox" name="Aux" size=25 autocomplete="off" maxlength=25 value="#iAux#">
	</td>
</tr>
<tr>
	<td>Reg Pioneer</td>
	<td>
		<input type="textbox" name="regPioneer" size=25 autocomplete="off" maxlength=25 value="#iRegPioneer#">
	</td>
</tr>
<tr>
	<td>Special Pioneer</td>
	<td>
		<input type="textbox" name="specialPioneer" size=25 autocomplete="off" maxlength=25 value="#iSpecialPioneer#">
	</td>
</tr>
<tr>
	<td>unbapt</td>
	<td>
		<input type="textbox" name="unbapt" size=25 autocomplete="off" maxlength=25 value="#iUnbapt#">
	</td>
</tr>


<tr>
	<td>Remarks</td>
	<td>
		<input type="textbox" name="Remarks" size=25 autocomplete="off" maxlength=25 value="#iRemarks#">
	</td>
</tr>

<tr>
	<td>Minutes</td>
	<td>
		<input type="textbox" name="minute" size=25 autocomplete="off" maxlength=25 value="#iMinute#">
	</td>
</tr>
<tr>
	<td>Sent to Branch</td>
	<td>
		<input type="textbox" name="submittedToBranch" size=2 autocomplete="off" maxlength=1 value="#isubmittedToBranch#">
	</td>
</tr>
<tr>
	<td>Card Transfered Out</td>
	<td>
		<input type="textbox" name="CARDTRANSFEREDOUT" size=2 autocomplete="off" maxlength=1 value="#loadPub.CARDTRANSFEREDOUT#">
	</td>
</tr>
<tr>
	<td>Home Phone</td>
	<td>
		<input type="textbox" name="telephone" size=25 autocomplete="off" maxlength=25 value="#loadPub.telephone#">
	</td>
</tr>
<tr>
	<td>Mobile Phone</td>
	<td>
		<input type="textbox" name="mobile" size=25 autocomplete="off" maxlength=25 value="#loadPub.mobile#">
	</td>
</tr>
<tr>
	<td colspan=2>
		<input type=submit value="submit">
	</td>
</tr>
<cfloop query="loadMissing">
<cfif loadPub.email neQ "">
<tr>
	
	<td colspan=3>
	<a href="http://beta.timothycunningham.com/serviceReport/timeSlip.cfc?method=sendPDF&servicereportID=#serviceReportID#">timeSlip.cfc?method=sendPDF&servicereportID=#serviceReportID# (#imonth# #iYear#)</a>
	</td>
</tr>
</cfif>
</cfloop>
</form>

<cfset monthlist = "9,10,11,12,1,2,3,4,5,6,7,8">
<cfloop list="#monthList#" index="curMonth">
	<a href="addTime.cfm?serviceYear=#serviceYear#&iMonth=#curMonth#&publisherID=#publisherID#&iYear=#iYear#">#MonthAsString(curMonth)# #iYear#</a> |
</cfloop>

<a href="http://beta.timothycunningham.com/Report/missingTime.cfm">Show Missing Time Report</a>

</cfoutput>


