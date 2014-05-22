
<cfquery name="loadLastReport" datasource="#application.DSN#">
	SELECT  TOP 1 *
	FROM ServiceReport
	WHERE 1 = 1
	AND hours > 1
	ORDER BY iYear DESC, Imonth DESC
</cfquery>

<cfset iYear = loadLastReport.iyear>
<cfset iMonth = loadLastReport.imonth>

<cfquery name="load" datasource="#application.DSN#">
	SELECT  convert(int, round(ISNULL(dbo.runningAvg(serviceReportID),0),0)) as runningAVG, P.lname, P.fname, P.publisherID,  CASE WHEN P.elder = 1 THEN 'E' WHEN  P.servant = 1 THEN 'MS' ELSE '&nbsp;' END as servant
	FROM Publisher P, ServiceReport SR
	WHERE P.gender = 'M'
	AND SR.publisherID = P.publisherID
	---AND SR.submittedToBranch = 1
	AND SR.iyear = '#iYear#'
	AND SR.imonth = '#iMonth#'
	AND P.cardTransferedOut = 0
	ORDER BY dbo.runningAvg(serviceReportID) DESC
</cfquery>

<cfquery name="load" datasource="#application.DSN#">
	SELECT  AVG(convert(decimal, hours)) as runningAVG, P.lname, P.fname, P.publisherID
	FROM Publisher P, ServiceReport SR
	WHERE 1 = 1
	AND SR.publisherID = P.publisherID
	---AND SR.submittedToBranch = 1
	--AND SR.iyear = '#iYear#'
	--AND SR.imonth = '#iMonth#'
	AND P.cardTransferedOut = 0
	AND P.publisherID IN (
52, --Aaron McDonald
53, -- Eileen Mcdonald
55, -- Leslie McDonald
69, -- Joan Pettigrew
92, -- Denise Whitmire
102, -- Vanessa Flores
7, -- Marsha Anderson
1, -- Marice Adams
25, -- Michelle Cunningham
96, -- Annette Young
35, -- Doug Doyle
23, -- Linda Cooper
87, -- Jonnie Thomas
111, -- Lessette Thomas
93, -- Elana Woodley
95, -- Zelima Woodley
110, -- Paris Woodley
14, -- Alyson Bynum
16, -- Sandra Bynum
29, -- DD3
30, -- Archecia Danzie
32, -- Madison Danzie
59, -- Monica Norwood
66 -- ashia paster
)
	GROUP BY P.lname, P.fname, P.publisherID
	ORDER BY AVG(convert(decimal, hours)) DESC
</cfquery>




<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml"><head>
<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
<title>Worldwide Association of Jehovahâs Witnesses</title>
<style type="text/css">@import "../ServiceReport/general.css";</style>

<div id="content">

                <h2>Field Service 6 month avg (As of #iMonth#/#iYear#) for family members of men in the congregation</h2>

               <table border="1" cellspacing="0" cellpadding="2" class="width100 confirm">
               <col width="14%"></col><col span="2" width="12%"></col>
               <tr>
                  <th>Name</th>
                  <th>6 mo avg</th>
                 
               </tr>
               <cfloop query="load">
               		
               <tr class="ralign">
				
                  <th class="ralign" style="width:25%;">#load.lname#, #load.Fname#</th>

                  <td class="FSFigure ">#load.runningAVG#</td>
                  
               </tr>
               </cfloop>
               
                
      

</body>
</html>

</cfoutput>