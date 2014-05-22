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
<Cfset serviceYear = loadLastReport.serviceYear>

<cfquery name="load" datasource="#application.DSN#">
	SELECT serviceReport.publisherID, serviceReport.lname, serviceReport.fname, sum(hours) as totalHours, sum(rbc) as totalRBC, (SELECT count(*) FROM serviceReport SR1 WHERE sr1.publisherID =  serviceReport.publisherID AND sr1.serviceYear=2010) * 50 as targetTime,
	 CASE WHEN datediff(year, dob,'1/1/1900') = 0 THEN 'Unknown' ELSE CONVERT(varchar, datediff(year, dob, getDate())) END as age,
	 Publisher.telephone, Publisher.mobile
	FROM serviceReport, publisher
	WHERE regPioneer = 1
	AND serviceYear = 2010
    AND serviceReport.publisherID = publisher.publisherID
	GROUP BY serviceReport.publisherID, serviceReport.lname, serviceReport.fname, publisher.dob,Publisher.telephone, Publisher.mobile
	ORDER BY serviceReport.lname, serviceReport.fname
</cfquery>



<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml"><head>
<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
<title>Worldwide Association of Jehovah’s Witnesses</title>
<style type="text/css">@import "../ServiceReport/general.css";</style>

<div id="content">

                <h2>Pioneers</h2>

               <table border="1" cellspacing="0" cellpadding="2" class="width100 confirm">
               <col width="14%"></col><col span="7" width="12%"></col>
               <tr>
					<th>Name</th>
					<th>Hours</th>
					<th>RBC</th>
					<th>Age</th>
					<th>Phone</th>
					<th>Mobile</th>
               </tr>
               <cfloop query="load">
               		
               <tr class="ralign">
				
                  <th class="ralign" style="width:25%;">#load.lname#, #load.Fname#</th>

                  <td class="FSFigure ">#load.totalHours#</td>
                  <td class="FSFigure ">#load.totalRBC#</td>
                  <td class="FSFigure ">#load.age#</td>
                  <td class="FSFigure ">#load.telephone#</td>
                   <td class="FSFigure ">#load.mobile#</td>
                 
               </tr>
               </cfloop>
               
                
      

</body>
</html>

</cfoutput>