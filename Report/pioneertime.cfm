<cfparam name="lowHourMark" default="5">
<cfquery name="loadLastReport" datasource="#application.DSN#">
	SELECT  TOP 1 *
	FROM ServiceReport
	WHERE submittedToBranch = 1
	AND hours > 1
	ORDER BY iYear DESC, Imonth DESC
</cfquery>
<cfquery name="lastIncomplete" datasource="#application.DSN#">
	SELECT  TOP 1 *
	FROM ServiceReport
	WHERE submittedToBranch = 0
	ORDER BY serviceReportID DESC
</cfquery>



<cfset iYear = loadLastReport.iyear>
<cfset iMonth = loadLastReport.imonth>
<Cfset serviceYear = loadLastReport.serviceYear>

<cfquery name="load" datasource="#application.DSN#">
	SELECT serviceReport.publisherID, publisher.email,serviceReport.lname, serviceReport.fname, sum(hours) as totalHours, sum(rbc) as totalRBC, (SELECT count(*) FROM serviceReport SR1 WHERE sr1.publisherID =  serviceReport.publisherID AND sr1.serviceYear=#serviceYear# AND regPioneer=1 AND (sr1.imonth <> #lastIncomplete.imonth# )) * 70 as targetTime,
	 CASE WHEN datediff(year, dob,'1/1/1900') = 0 THEN 'Unknown' ELSE CONVERT(varchar, datediff(year, dob, getDate())) END as age,
	 Publisher.telephone, Publisher.mobile
	FROM serviceReport, publisher
	WHERE regPioneer = 1
	AND serviceYear = #serviceYear#
    AND serviceReport.publisherID = publisher.publisherID
	AND (serviceReport.imonth <> #lastIncomplete.imonth#)
	GROUP BY serviceReport.publisherID, publisher.email,serviceReport.lname, serviceReport.fname, publisher.dob,Publisher.telephone, Publisher.mobile
	ORDER BY  sum(hours) ASC, serviceReport.lname, serviceReport.fname
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
               <col width="14%"></col><col span="9" width="12%"></col>
               <tr>
					<th>Name</th>
					<th>Target</th>
					<th>Hours</th>
					<th>Difference</th>
					<th>email</th>
					<th>Phone</th>
					<th>Mobile</th>
					<th>Missing<br>Months</th>
               </tr>
               <cfloop query="load">
			   <cfquery name="missing" datasource="#application.DSN#">
					SELECT *
					FROM serviceReport
					WHERE publisherID = #load.publisherID#
					AND hours < 1
					AND (serviceReport.imonth <> #lastIncomplete.imonth#)
			   </cfquery>
			   <cfset missinglist = valueList(missing.imonth)>
               <cfset difference = 		load.totalHours - load.targetTime>
			   <cfif difference GT 0>
				<cfset difference = "<b>+#difference#</b>">
			   </cfif>
			   
			   <cfif difference LT 0>
				<cfset difference = "<font color='red'><b>#difference#</b></font>">
			   </cfif>
			   
               <tr class="ralign">
				
                  <th class="ralign" style="width:15%;">#load.lname#, #load.Fname#</th>
				 <td class="FSFigure ">#load.targetTime#</td>
                  <td class="FSFigure ">#load.totalHours#</td>
				  <td class="FSFigure ">#difference#</td>
                  <td class="FSFigure ">#load.email#</td>
                  <td class="FSFigure ">#load.telephone#</td>
                   <td class="FSFigure " >#load.mobile#</td>
				   <td class="FSFigure ">#missinglist# </td>
                 
               </tr>
               </cfloop>
               
                
      

</body>
</html>

</cfoutput>