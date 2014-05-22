
<cfquery name="groupList" datasource="#application.DSN#">
	SELECT sg.*, P.fname, P.lname
	FROM serviceGroup SG, Publisher P 
	Where  SG.serviceGroupID = P.serviceGroupID
	AND SG.active = 1
	AND P.cardTransferedOut = 0
	ORDER By SG.groupoverseerName, P.lname, P.fname
</cfquery>

<cfoutput>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml"><head>
<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
<title>Service Group Report</title>
<style type="text/css">
<cfinclude template="general.css">
</style>

<div id="content">

                <h2>Field Service Group List</h2>

              <table border="1" cellspacing="0" cellpadding="2" class="width100 confirm">
				<cfset group = "">
			   <cfloop query="groupList">
			   <cfif groupOverSeerName NEQ group>
               <tr class="ralign">

                  <td class="FSFigure "><h2>#groupOverseername#</h2></td>
               </tr>
			   <cfset group = "#groupOverseername#">
			   <tr>
                  <th>Publishers</th>
                  
               </tr>
			   </cfif>
               
            
               <tr class="lalign">

                  <td class="FSFigure ">#lname#, #fname#</td>
               </tr>
			   </cfloop>
               </table><br />
               
      
Last list update: #dateFormat(now(), "mm/dd/yyyy")#
</body>
</html>

</cfoutput>