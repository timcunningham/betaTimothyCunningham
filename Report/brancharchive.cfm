<cfparam name="imonth" default="#datePart("m", dateAdd("M", -1, now()))#">
<cfparam name="iYear" default="#datePart("yyyy", dateAdd("M", -1, now()))#">
<cfoutput>imonth : #imonth#</cfoutput>
<cfquery name="pubCount" datasource="#application.DSN#">
	SELECT count(*) as iCount, sum(books) as books, sum(brochure) as brochures, sum(hours) as hours, sum(mags) as mags, sum(RV) as RVs, sum(BS) as Studies
	FROM serviceReport 
	Where  submittedToBranch = 0
	AND hours > 0
	AND aux = 0
	AND regPioneer = 0
	---AND dbo.isActivePublisher(publisherID) > 0
</cfquery>

<cfquery name="auxCount" datasource="#application.DSN#">
	SELECT count(*) as iCount, sum(books) as books, sum(brochure) as brochures, sum(hours) as hours, sum(mags) as mags, sum(RV) as RVs, sum(BS) as Studies
	FROM serviceReport 
	Where  submittedToBranch = 0
	AND hours > 40
	--AND aux = 0
	AND regPioneer = 0
	---AND dbo.isActivePublisher(publisherID) > 0
</cfquery>

<cfquery name="pioCount" datasource="#application.DSN#">
	SELECT count(*) as iCount, sum(books) as books, sum(brochure) as brochures, sum(hours) as hours, sum(mags) as mags, sum(RV) as RVs, sum(BS) as Studies
	FROM serviceReport 
	Where  submittedToBranch = 0
	AND regPioneer = 1
	---AND dbo.isActivePublisher(publisherID) > 0
</cfquery>


<cfquery name="allcount" datasource="#application.DSN#">
	SELECT count(*) as iCount, sum(books) as books, sum(brochure) as brochures, sum(hours) as hours, sum(mags) as mags, sum(RV) as RVs, sum(BS) as Studies
	FROM serviceReport 
	Where  submittedToBranch = 0
	AND hours > 0
	---AND dbo.isActivePublisher(publisherID) > 0
</cfquery>

<cfquery name="activepublist" datasource="#application.DSN#">
	SELECT  lname + ', ' + fname as noTimeName
	FROM publisher 
	Where  dbo.isActivePublisher(publisherID) > 0
	AND cardTransferedOut = 0
	AND NOT EXISTS (SELECT * FROM serviceReport WHERE hours > 0 AND submittedToBranch=0 AND publisher.publisherID = serviceReport.publisherID)
	ORDER BY lname, fname
</cfquery>



<cfquery name="activepub" datasource="#application.DSN#">
	SELECT  count(*) as iCount
	FROM publisher 
	Where  dbo.isActivePublisher(publisherID) > 0
	AND cardTransferedOut = 0
</cfquery>



<cfoutput>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml"><head>
<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
<title>Worldwide Association of Jehovah’s Witnesses</title>
<style type="text/css">@import "general.css";</style>

<div id="content">

                <h2>Field Service</h2>

               <p>Please confirm that the report is correct.</p><table border="1" cellspacing="0" cellpadding="2" class="width100 confirm">

               <caption>#imonth# #iyear#</caption>
               <col width="14%"></col><col span="7" width="12%"></col>
               <tr>
                  <th>&nbsp;</th>
                  <th>Count</th>
                  <th>Books</th>
                  <th>Brochures</th>

                  <th>Hours</th>
                  <th>Magazines</th>
                  <th>Return Visits</th>
                  <th>Studies</th>
               </tr>
               <tr class="ralign">
                  <th class="ralign">Publishers</th>

                  <td class="FSFigure ">#pubCount.iCount#</td>
                  <td class="FSFigure ">#pubCount.books#</td>
                  <td class="FSFigure ">#pubCount.brochures#</td>
                  <td class="FSFigure ">#pubCount.hours#</td>
                  <td class="FSFigure ">#pubCount.mags#</td>
                  <td class="FSFigure ">#pubCount.rvs#</td>

                  <td class="FSFigure ">#pubCount.Studies#</td>
               </tr>
               <tr class="ralign">
                  <th class="ralign">Auxilary Pioneers</th>

                  <td class="FSFigure ">#auxCount.iCount#</td>
                  <td class="FSFigure ">#auxCount.books#</td>
                  <td class="FSFigure ">#auxCount.brochures#</td>
                  <td class="FSFigure ">#auxCount.hours#</td>
                  <td class="FSFigure ">#auxCount.mags#</td>
                  <td class="FSFigure ">#auxCount.rvs#</td>

                  <td class="FSFigure ">#auxCount.Studies#</td>
               </tr>
               <tr class="ralign">
                  <th class="ralign">Pioneers</th>

                  <td class="FSFigure ">#pioCount.iCount#</td>
                  <td class="FSFigure ">#pioCount.books#</td>
                  <td class="FSFigure ">#pioCount.brochures#</td>
                  <td class="FSFigure ">#pioCount.hours#</td>
                  <td class="FSFigure ">#pioCount.mags#</td>
                  <td class="FSFigure ">#pioCount.rvs#</td>

                  <td class="FSFigure ">#pioCount.Studies#</td>
               </tr>
				<tr class="ralign">
                     <th class="totals ralign">Totals</th>
                     <td class="totals">#allcount.iCount#</td>
                     <td class="totals">#allcount.books#</td>
                     <td class="totals">#allcount.brochures#</td>

                     <td class="totals">#allcount.hours#</td>
                     <td class="totals">#allcount.mags#</td>
                     <td class="totals">#allcount.rvs#</td>
                     <td class="totals">#allcount.Studies#</td>
                  </tr></table><br />
                <table cellspacing="0" cellpadding="4" class="table-rows confirm">
                <caption class="nowrap">Congregation Members</caption> 
                   <tr>

                      <td><label for="txtActivePubCount">Active Publishers</label>&nbsp;</td>
                      <td class="FSFigure ">#activepub.icount#</td>
                  </tr>
                   <caption class="nowrap">Irregular</caption> 
					<tr>
                      <td><label for="txtActivePubCount">Irregular Publishers</label>&nbsp;</td>
                  </tr>
                      <cfloop query="activepublist">
                       <tr>
                      <td class="FSFigure ">#activepublist.noTimeName#</td>
                      </tr>
                      </cfloop>
                  </tr>
                </table> 
      

</body>
</html>

</cfoutput>