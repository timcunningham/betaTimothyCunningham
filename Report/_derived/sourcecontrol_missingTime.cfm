<cfparam name="month" default="all">

<cfquery name="loadLastReport" datasource="#application.DSN#">
	SELECT  TOP 1 *
	FROM ServiceReport
	WHERE submittedToBranch = 0
	AND hours > 1
	ORDER BY iYear DESC, Imonth DESC
</cfquery>


<cfset iYear = loadLastReport.iyear>
<cfset iMonth = loadLastReport.imonth>

<cfquery name="load" datasource="#application.DSN#">
	SELECT P.publisherID, SG.groupName, SR.lname, SR.fname, SR.imonth, SR.iyear, P.telephone, P.mobile
	FROM serviceReport SR, serviceGroup SG, publisher P
	WHERE SR.submittedToBranch = 0
	AND SR.ServiceGroupID = SG.ServiceGroupID
	AND SR.hours < 1
	AND P.publisherID = SR.publisherID
	--AND dbo.isActivePublisher(SR.publisherID) > 0
	AND P.cardTransferedOut = 0
	<cfif isNumeric(month)>
	AND SR.imonth = '#month#'
	</cfif>
	ORDER BY SG.groupName, SR.lname, SR.fname
</cfquery>



<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml"><head>
<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
<title>Worldwide Association of Jehovahâs Witnesses</title>
<style type="text/css">@import "../ServiceReport/general.css";</style>

<div id="content">

                <h2>Missing Time</h2>
				<h1><a href="missingTime.cfm?month=#loadLastReport.imonth#">This month</a> &nbsp; <a href="missingTime.cfm?month=all">All</a></h1>
               <table border="1" cellspacing="0" cellpadding="2" class="width100 confirm">
               <col width="14%"></col><col span="8" width="12%"></col>
               <tr>
                  <th>Group Name</th>
                  <th  style="width:25%;">Publisher&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
                 <!--- <th style="width:30%;">Telephone</th> --->
		 <th>Month</th>
                  <th>Books</th>
                  <th>Brochure</th>
                  <th>Hours</th>
                  <th>Mags</th>
                  <th>RV</th>
                  <th>BS</th>
               </tr>
               <cfloop query="load">
               		
               <tr class="ralign">
				
                  <th class="ralign" style="width:25%;">#groupName#</th>

                  <td class="FSFigure " style="width:30%;">
<a href="http://beta.timothycunningham.com/publishercard/addTime.cfm?publisherID=#publisherID#&imonth=#imonth#&iyear=#iyear#">
#lname#, #fname#</a<</td>
                  <!---<td class="FSFigure Center"><cfif mobile IS "">#telephone#<cfelse>#mobile#</cfif></td> --->
		<td class="FSFigure "><b>#monthasString(imonth)#<b></td>
                  <td class="FSFigure ">______</td>
                  <td class="FSFigure ">______</td>
                  <td class="FSFigure ">______</td>
                  <td class="FSFigure ">______</td>
                  <td class="FSFigure ">______</td>
                  <td class="FSFigure ">______</td>
              
               </tr>
               </cfloop>
               
                
      

</body>
</html>

</cfoutput>