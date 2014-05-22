<cfcomponent >
	<cfset  timeSlipPath = expandPath("../") & "timeSlip.pdf">
	
	<cffunction name="sendPDF" access="remote">
		<cfargument name="serviceReportID"  required="true">
		<cfdump var="#arguments.serviceReportID#">
		<cfset var serviceReport = "">
		<cfset var pdfPath = "">
		<cfquery name="serviceReport" datasource="#application.DSN#">
			SELECT *
			FROM ServiceReport SR, Publisher P
			WHERE SR.publisherID = P.publisherID
			AND SR.serviceReportID = #arguments.serviceReportID#
		</cfquery>
		<cfset pdfPath = getPDF(serviceReport)>
		<cfset emailPDF(pdfPath, serviceReport)>
	</cffunction>
	
	<cffunction name="getPDF" access="private">
		<cfargument name="serviceReport" type="query" required="true">
		<cfset var timeSlip = "">
		<cfset var destPDF = "">
		<cfset var dateofBirth = "">
		<cfset var immersed = "">
		
		<cfset destPDF = expandPath("../") & serviceReport.Lname & " " & serviceReport.fname & " " & monthAsString(serviceReport.imonth) & serviceReport.iYear & ".pdf">
		<cfpdfform action="read" result="timeSlip" source="#timeSlipPath#" >
		
		</cfpdfform>
		<cfdump var="#serviceReport#">
		<cfdump var="#timeSlip#">
		<cfset dateofBirth = serviceReport.dob>
		<cfif isDate(dateOfBirth)>
			<cfset dateofBirth = dateformat(dateofBirth, "mm/dd/yyyy")>
		</cfif>
		<cfset immersed = serviceReport.DATEIMMERSED>
		<cfif isDate(immersed)>
			<cfset immersed = dateformat(immersed, "mm/dd/yyyy")>
		</cfif>
		
		<cfpdfform action="populate" source="#timeSlipPath#" destination="#destPDF#" overwrite="yes" >
			<cfpdfformparam name="name" 		value="#serviceReport.fname# #serviceReport.lname#" >
			<cfpdfformparam name="month" 		value="#monthAsString(serviceReport.imonth)# #serviceReport.iYear#" >
			<cfpdfformparam name="email" 		value="#serviceReport.email#" >
			<cfpdfformparam name="address" 		value="#serviceReport.address1#" >
			<cfpdfformparam name="city" 		value="#servicereport.city#" >
			<cfpdfformparam name="state" 		value="#serviceReport.state#" >
			<cfpdfformparam name="zip" 			value="#serviceReport.zip#" >
			<cfpdfformparam name="homephone" 	value="#serviceReport.telephone#" >
			<cfpdfformparam name="mobilephone"	value="#serviceReport.mobile#" >
			<cfpdfformparam name="dob"			value="#dateOfBirth#" >
			<cfpdfformparam name="immersed"		value="#immersed#" >
			<cfpdfformparam name="UUID"			value="#serviceReport.UUID#" >
			<cfpdfformparam name="serviceReportID"value="#serviceReport.serviceReportID#" >
			
		</cfpdfform>
		<cfreturn destPDF>
	</cffunction>
	
	<cffunction name="emailPDF" access="private" >
		<cfargument name="pdfPath" 			type="string" 	required="True">
		<cfargument name="serviceReport" 	type="query" 	required="True">
		<cfargument name="body" 			type="string" 	required="true" 	default="">
		<cfset var timeSlip = "">
		<cfset var pdf_from = "">
		
		<cfpdf action="read" name="pdf_form" source="#arguments.pdfPath#">
		<cfif  arguments.body IS "">
<cfsavecontent variable="arguments.body">
<cfoutput>
Dear #serviceReport.fname# #serviceReport.lname#,<br>
<br>
Attached is a PDF Form, please <b>download</b> it and open it with the latest version of <a href="http://get.adobe.com/reader/">Adobe PDF Reader</a> <b>*on a computer*</b> (PDF Forms will not work on a phone or tablet.) Fill out your Field Service Totals for #monthAsString(serviceReport.imonth)# #serviceReport.iYear# then click the button that says, "Turn In Time." This will send me your Field Service Report.<br>
<br>You may be asked by Adobe PDF reader if it is ok to connect to http://beta.timothycunningham.com please click "Allow".<br><br>
Also note, if you make changes to the publisher information section it will update my information in the file as well.<br>
The Notes section will show up as a note on your publisher record card.<br>
You may also be asked if you wish to save or print out the PDF, this is unnecessary.<br>
Thanks,<br>
<br>
Tim Cunningham<br>
Byron, GA<br>			
</cfoutput>
</cfsavecontent>
		</cfif>
			
		
		<cfpdf action="read" name="timeSlip" source="#pdfPath#">
		
		<cfmail to="#serviceReport.email#" cc="timcunningham71@gmail.com" subject="Field Service Report for #serviceReport.fname# #serviceReport.lname# #monthAsString(serviceReport.imonth)# #serviceReport.iYear#" 
				 server="mail2.idminc.com" from="cunningham@idminc.com"
				 type="html">
			#arguments.body#
			<cfmailparam file="#serviceReport.fname# #serviceReport.lname# #monthAsString(serviceReport.imonth)# #serviceReport.iYear# timeslip.pdf" type="application/pdf" content="#pdf_form#">	  
		</cfmail>
	</cffunction>
	
	<cffunction name="turnInTime">
		<cfargument name="slip" type="struct" required="true"> 
		<cfset var noTamper = checkNoTamper(arguments.slip)>
		<cfif noTamper neq "safe">
			<cfreturn noTamper>
		</cfif>	
		<cfset updateTime(slip)>
		<cfoutput>Thank you! Your time has been updated. A confirmation email will be sent to you to #slip.email#.</cfoutput>
		<cfset confirmEmail(slip)>
		<cfreturn "Time Updated">
		
		
	</cffunction>
	
	<cffunction name="checkNoTamper">
		<cfargument name="slip" type="struct" required="true"> 
		<cfset var serviceReport = "">
		<cfif ISDefined("slip.serviceReportID") IS False OR ISDefined("slip.UUID") is False>
			<cfmail to="timcunningham71@gmail.com" from="cunningham@idminc.com" subject="Missing UUID or ServiceReportID #now()#" type="html" server="mail2.idminc.com" >
				<cfdump var="#arguments.slip#" label="slip">
				<cfdump var="#cgi#" label="cgi">
			</cfmail> 	
			<cfreturn "Field Service Slip missing critcial information. Please use paper slip to turn in time.">
		</cfif>
		
		<cfif isNumeric(slip.serviceReportID) is False>
			<cfmail to="timcunningham71@gmail.com" from="cunningham@idminc.com" subject="Missing UUID or ServiceReportID #now()#" type="html" server="mail2.idminc.com" >
				<cfdump var="#arguments.slip#" label="slip">
				<cfdump var="#cgi#" label="cgi">
			</cfmail> 	
			<cfreturn "Field Service Slip missing critcial information. Please use paper slip to turn in time.">
		</cfif>
		
		<cfquery name="serviceReport" datasource="#application.DSN#">
			SELECT *
			FROM ServiceReport SR, Publisher P
			WHERE SR.publisherID = P.publisherID
			AND SR.serviceReportID = #slip.serviceReportID#
			AND SR.UUID = '#slip.UUID#'
		</cfquery>
		
		<cfif serviceReport.recordCount NEQ 1>
			<cfmail to="timcunningham71@gmail.com" from="cunningham@idminc.com" subject="Missing UUID or ServiceReportID #now()#" type="html"  server="mail2.idminc.com" >
			<cfdump var="#arguments.slip#" label="slip">
			<cfdump var="#cgi#" label="cgi">
			</cfmail> 	
			<cfreturn "Field Service Slip may have been tampered with, please use paper slip to turn in time.">
		</cfif>
		<cfreturn "safe">
	</cffunction>
	
	<cffunction name="updateTime" >
		<cfargument name="slip" type="struct" required="true">
		<cfset var serviceReport = "">
		<cfset var pubInfo = "">
		<cfset var submittedToBranch = 0>
		<cfif ISDefined("slip.inactive") AND slip.inactive IS True>
			<cfset submittedToBranch = 1>
		</cfif>
		
		<cfquery name="serviceReport" datasource="#application.DSN#">
			UPDATE ServiceReport
			SET temp = 0
			<cfif ISDefined("slip.BOOKSTOTAL")>
				,books= <cfqueryparam cfsqltype="cf_sql_integer" value="#slip.BOOKSTOTAL#"> 
			</cfif>
			<cfif ISDefined("slip.BROCHURESTOTAL")>
				,brochure= <cfqueryparam cfsqltype="cf_sql_integer" value="#slip.BROCHURESTOTAL#"> 
			</cfif>
			<cfif ISDefined("slip.HOURSTOTAL")>
				,hours=<cfqueryparam cfsqltype="cf_sql_integer" value="#slip.HOURSTOTAL#">
			</cfif>
			<cfif ISDefined("slip.MAGSTOTAL")>
				,mags=<cfqueryparam cfsqltype="cf_sql_integer" value="#slip.MAGSTOTAL#">
			</cfif>
			<cfif ISDefined("slip.RVTOTAL")>
				,rv=<cfqueryparam cfsqltype="cf_sql_integer" value="#slip.RVTOTAL#">
			</cfif>
			<cfif ISDefined("slip.BSTOTAL")>
				,bs=<cfqueryparam cfsqltype="cf_sql_integer" value="#slip.BSTOTAL#">
			</cfif>
			<cfif ISDefined("slip.note")>
				,remarks=<cfqueryparam cfsqltype="cf_sql_varchar" value="#submittedToBranch#">
			</cfif>
			<cfif ISDefined("slip.inactive")>
				,submittedToBranch=<cfqueryparam cfsqltype="cf_sql_varchar" value="#submittedToBranch#">
			</cfif>
			WHERE serviceReportID = <cfqueryparam cfsqltype="cf_sql_integer" value="#slip.serviceReportID#">
			AND submittedToBranch = 0
		</cfquery>
		
		<cfquery name="pubInfo" datasource="#application.DSN#">
			SELECT publisherID 
			FROM serviceReport
			WHERE serviceReportID = <cfqueryparam cfsqltype="cf_sql_integer" value="#slip.serviceReportID#">
		</cfquery>

		
		<cfif pubInfo.recordCount GT 0 and isNumeric(pubInfo.publisherID)>
			<cfquery name="serviceReport" datasource="#application.DSN#">
				Update publisher
				SET sms = sms
				<cfif ISDefined("slip.email")>
					,email=<cfqueryparam cfsqltype="cf_sql_varchar" value="#slip.email#">
				</cfif>
				<cfif ISDefined("slip.address")>
					,address1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#slip.address#">
				</cfif>
				<cfif ISDefined("slip.city")>
					,city=<cfqueryparam cfsqltype="cf_sql_varchar" value="#slip.city#">
				</cfif>
				<cfif ISDefined("slip.state")>
					,state=<cfqueryparam cfsqltype="cf_sql_varchar" value="#slip.state#">
				</cfif>
				<cfif ISDefined("slip.zip")>
					,zip=<cfqueryparam cfsqltype="cf_sql_varchar" value="#slip.zip#">
				</cfif>
				<cfif ISDefined("slip.homephone")>
					,telephone=<cfqueryparam cfsqltype="cf_sql_varchar" value="#slip.homephone#">
				</cfif>
				<cfif ISDefined("slip.mobilePhone")>
					,mobile=<cfqueryparam cfsqltype="cf_sql_varchar" value="#slip.mobilePhone#">
				</cfif>
				<cfif ISDefined("slip.dob")>
					,dob=<cfqueryparam cfsqltype="cf_sql_date" value="#slip.dob#">
				</cfif>
				<cfif ISDefined("slip.immersed")>
					,dateImmersed=<cfqueryparam cfsqltype="cf_sql_date" value="#slip.immersed#">
				</cfif>
				WHERE publisherID = <cfqueryparam cfsqltype="cf_sql_integer" value="#pubInfo.publisherID#">
			</cfquery>
		</cfif>
	</cffunction>
	
	<cffunction name="confirmEmail" >
			<cfargument name="slip" type="struct" required="true">
			<cfset var serviceReport = "">
			<cfset var pastTime = "">
						
			<cfquery name="serviceReport" datasource="#application.DSN#">
				SELECT *
				FROM ServiceReport SR, Publisher P
				WHERE SR.publisherID = P.publisherID
				AND SR.serviceReportID = <cfqueryparam cfsqltype="cf_sql_integer" value="#slip.serviceReportID#">
			</cfquery>
			
			<cfquery name="pastTime"  datasource="#application.DSN#">
				SELECT Top 12 *
				FROM ServiceReport SR, Publisher P
				WHERE SR.publisherID = P.publisherID
				AND P.publisherID = <cfqueryparam cfsqltype="cf_sql_integer" value="#serviceReport.publisherID#">
				ORDER BY iYear DESC, imonth DESC
			</cfquery>
				
	
			<cfmail to="#serviceReport.email#" cc="timcunningham71@gmail.com" subject="Confirmed: Report for #serviceReport.fname# #serviceReport.lname# #monthAsString(serviceReport.imonth)# #serviceReport.iYear#" 
				 server="mail2.idminc.com" from="cunningham@idminc.com"
				 type="html">
<cfoutput>
<pre style="font-size:large;">
	Month:			#monthAsString(serviceReport.imonth)# #serviceReport.iYear#
	Name: 			#serviceReport.fname# #serviceReport.lname#
	
	Books:			#serviceReport.books#
	Brochures:		#serviceReport.brochure#
	Hours:			#serviceReport.hours#
	Magazines:		#serviceReport.mags#
	RV's:			#serviceReport.RV#
	Bible Study:		#serviceReport.bs#
	
	Remarks:		#serviceReport.remarks#
	
	Time from last 12 months:
	-------------------------------------------------------------
</pre>	

<table>
	<tr><td>Month</td><td>Year</td><td>Books</td>		<td>Brochures</td>		<td>Hours</td>		<td>Mags</td>		<td>RVs</td>		<td>Bible<br>Study</td>
</tr>
<cfloop query="pastTime">
<tr><td>#monthAsString(imonth)#</td><td>#iYear#</td><td>#books#	</td><td>#brochure#	</td><td>#hours#</td><td>#mags#</td><td>#rv#</td><td>#bs#</td></tr>
</cfloop>
</cfoutput>
		</cfmail>
		</cffunction>

<cfscript>
/**
 * Tests passed value to see if it is a valid e-mail address (supports subdomain nesting and new top-level domains).
 * Update by David Kearns to support '
 * SBrown@xacting.com pointing out regex still wasn't accepting ' correctly.
 * Should support + gmail style addresses now.
 * More TLDs
 * Version 4 by P Farrel, supports limits on u/h
 * Added mobi
 * v6 more tlds
 * 
 * @param str      The string to check. (Required)
 * @return Returns a boolean. 
 * @author Jeff Guillaume (SBrown@xacting.comjeff@kazoomis.com) 
 * @version 7, May 8, 2009 
 */
function isEmail(str) {
    return (REFindNoCase("^['_a-z0-9-\+]+(\.['_a-z0-9-\+]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*\.(([a-z]{2,3})|(aero|asia|biz|cat|coop|info|museum|name|jobs|post|pro|tel|travel|mobi))$",
arguments.str) AND len(listGetAt(arguments.str, 1, "@")) LTE 64 AND
len(listGetAt(arguments.str, 2, "@")) LTE 255) IS 1;
}
</cfscript>	
	
</cfcomponent>