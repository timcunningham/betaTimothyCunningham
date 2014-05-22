<cfparam name="lowHourMark" default="5">
<cfquery name="loadLastReport" datasource="#application.DSN#">
	SELECT  TOP 1 *
	FROM ServiceReport
	WHERE submittedToBranch = 1
	AND hours > 1
	ORDER BY iYear DESC, Imonth DESC
</cfquery>

<cfset iYear = loadLastReport.iyear>
<cfset iMonth = loadLastReport.imonth>

<cfquery name="load" datasource="#application.DSN#">
	SELECT  convert(int, round(ISNULL(dbo.runningAvg(serviceReportID),0),0)) as runningAVG, P.lname, P.fname, P.publisherID, P.telephone, P.mobile,
		 CASE WHEN datediff(year, dob,'1/1/1900') = 0 THEN 'Unknown' ELSE CONVERT(varchar, datediff(year, dob, getDate())) END as age
	FROM Publisher P, ServiceReport SR
	WHERE SR.publisherID = P.publisherID
	AND SR.submittedToBranch = 1
	AND SR.iyear = '#iYear#'
	AND SR.imonth = '#iMonth#'
	AND dbo.runningAvg(serviceReportID) <= #lowHourMark#
	AND P.cardTransferedOut = 0
	ORDER BY dbo.runningAvg(serviceReportID) DESC
</cfquery>



<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml"><head>
<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
<title>Worldwide Association of Jehovah’s Witnesses</title>
<style type="text/css">@import "../ServiceReport/general.css";</style>

<div id="content">

                <h2>Low hour publishers(#lowHourMark# or less)</h2>

               <table border="1" cellspacing="0" cellpadding="2" class="width100 confirm">
               <col width="14%"></col><col span="7" width="12%"></col>
               <tr>
					<th>Name</th>
					<th>6 mo avg</th>
					<th>Age</th>
					<th>Phone</th>
					<th>Mobile</th>
               </tr>
               <cfloop query="load">
               		
               <tr class="ralign">
				
                  <th class="ralign" style="width:25%;">#load.lname#, #load.Fname#</th>

                  <td class="FSFigure ">#load.runningAVG#</td>
                  <td class="FSFigure ">#load.age#</td>
                  <td class="FSFigure ">#load.telephone#</td>
                   <td class="FSFigure ">#load.mobile#</td>
                 
               </tr>
               </cfloop>
               
                
      

</body>
</html>

</cfoutput>