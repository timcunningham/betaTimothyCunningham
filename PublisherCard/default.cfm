<cfset pdfPath = "C:\Domains\timothyCunningham\PublisherCard\">
<cfset pdfFile = "publisherCard.pdf">

<cfparam name="serviceYear" default="2010">
<cfparam name="iMonth" default=9>

<cfpdfform source="#pdfPath##pdfFile#" result="resultStruct" action="read"/>

<cfquery name="loadPub" datasource="#application.DSN#">
	SELECT TOP 1 *
	FROM Publisher P
	WHERE fname LIKE '%felt%'
</cfquery>



<cfpdfform action="populate" source="#pdfPath##pdfFile#">
     <cfloop query="loadPub">
		<cfset male = "">
		<cfset female = "">
		<cfif gender IS "M">
			<cfset male = "X">
		<cfelseif gender IS "F">
			<cfset female = "X">
		</cfif>
		
		<cfset iDate = dateImmersed>
		<cfif ISDate(iDate)>
			<cfset iDate = dateformat(idate, "mm/dd/yyyy")>
		</cfif>
		
		<cfset iDOB = dob>
		<cfif ISDate(iDOB)>
			<cfset iDOB = dateformat(iDOB, "mm/dd/yyyy")>
		</cfif>
		
		
		<cfset anointedOrOtherSheep = "">
		<cfif anointed IS True>
			<cfset anointedOrOtherSheep = "Anointed">
		</cfif>

		<cfif otherSheep IS True>
			<cfset anointedOrOtherSheep = "Other Sheep">
		</cfif>
		
		<cfset iElder = "">
		<cfset iMinisterialServant = "">
		<cfset iRegularPioneer = "">
		
		<cfif elder IS True>
			<cfset iElder = "X">
		</cfif>
		
		<cfif servant IS True>
			<Cfset iMinisterialServant = "X">
		</cfif>	
		
		<cfif PIONEER IS True>
			<Cfset iRegularPioneer = "X">
		</cfif>			
		
	
		<cfpdfformparam name="name" value="#lname#, #fname#">
		<cfpdfformparam name="address" value="#address1# #city#, #state# #zip#">
		<cfpdfformparam name="HomePhone" value="#telephone#">
		<cfpdfformparam name="Mobile" value="#mobile#">
		<cfpdfformparam name="male" value="#male#">
		<cfpdfformparam name="female" value="#female#">
		<cfpdfformparam name="DOB" value="#iDOB#">
		<cfpdfformparam name="DateImmersed" value="#iDate#">
		<cfpdfformparam name="Elder" value="#iElder#">
		<cfpdfformparam name="MinisterialServant" value="#iMinisterialServant#">
		<cfpdfformparam name="RegularPioneer" value="#iRegularPioneer#">
		<cfpdfformparam name="anointedOthersheep" value="#anointedOrOtherSheep#">
		<cfpdfformparam name="year" value="#evaluate(serviceYear-1)#/#serviceYear#">
		
		<cfquery name="loadCard" datasource="#application.DSN#">
			SELECT *
			FROM ServiceReport
			WHERE publisherID = #publisherID#
				AND serviceYear  = '#serviceYear#'
		</cfquery>
		
		<cfloop query="loadCard">
			<cfpdfformparam name="Books_#iMonth#" value="#books#">
			<cfpdfformparam name="Brochure_#iMonth#" value="#Brochure#">
			<cfpdfformparam name="Hours_#iMonth#" value="#Hours#">
			<cfpdfformparam name="Mags_#iMonth#" value="#Mags#">
			<cfpdfformparam name="RV_#iMonth#" value="#RV#">
			<cfpdfformparam name="BS_#iMonth#" value="#BS#">
			<cfpdfformparam name="Remarks_#iMonth#" value="#Remarks#">
		</cfloop>
		
	</cfloop>
    
</cfpdfform>