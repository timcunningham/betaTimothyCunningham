<cfparam name=publisherID default=10>
<cfset source="c:/domains/timothycunningham/publisherCard/">
<cfset destination="c:/domains/timothycunningham/publisherCard/PDF_Form/">
<cfset pdffile="publisherInformationForm.pdf">

<!------>






<cfquery name="loadCard" datasource="#application.DSN#">
	SELECT *
	FROM Publisher
	WHERE publisherID =#publisherID#
</cfquery>

<cfquery name="loadgroup" datasource="#application.DSN#">
	SELECT *
	FROM serviceGroup
	WHERE serviceGroupID = '#loadCard.serviceGroupID#'
</cfquery>

<cfset group = loadGroup.groupName>




<cfquery name="loadTime" datasource="#application.DSN#">
	SELECT *
	FROM ServiceReport
	WHERE publisherID = #loadCard.publisherID#
	AND datediff(m, dbo.iDate(serviceReportID), getDate()) <= 6
	ORDER BY datediff(m, dbo.iDate(serviceReportID), getDate()) DESC
</cfquery>


<!---

<cfdump var="#loadCard#">
<cfpdfform source="c:/domains/timothycunningham/publisherCard/publisherInformationForm.pdf" result="resultStruct" action="read"/>

<cfdump var="#resultStruct#"> 

<cfabort>

ADDRESS1  	ANOINTED  	CARDTRANSFEREDOUT  	CITY  	DATEIMMERSED  	DOB  	ELDER  	EMAIL  	FNAME  	GENDER  	LNAME  	MOBILE  	OTHERSHEEP  	PIONEER  	PIONEERSCHOOL  	PIONEERSCHOOLYEAR  	PUBLISHERID  	SERVANT  	SERVICEGROUPID  	STATE  	TELEPHONE  	ZIP

		
Anointedorother  	 [empty string]
ContactInformation1 	[empty string]
ContactInformation2 	[empty string]
ContactInformation3 	[empty string]
ContactName 	[empty string]
DateImmersed 	[empty string]
HomeAddress 	[empty string]
HomeTelephone 	[empty string]
MobileTelephone 	[empty string]
Name 	[empty string]
dob 	[empty string]
email 	[empty string]
texting 	[empty string] --->


<cfpdfform action="populate" source="#source##pdfFile#" destination="C:\domains\timothyCunningham\PublisherCard\PDF_Form\Pubinfo_#loadCard.lname#_#loadCard.Fname#.pdf" overwrite=True>
		

  <cfloop query="loadCard">
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
		
		<cfpdfformparam name="group" value="#group#">
		<cfpdfformparam name="name" value="#lname#, #fname#">
		<cfpdfformparam name="HomeAddress" value="#address1# #city#, #state# #zip#">
		<cfpdfformparam name="HomeTelephone" value="#telephone#">
		<cfpdfformparam name="MobileTelephone" value="#mobile#">
		<cfpdfformparam name="male" value="#male#">
		<cfpdfformparam name="female" value="#female#">
		<cfpdfformparam name="DOB" value="#iDOB#">
		<cfpdfformparam name="DateImmersed" value="#iDate#">
		<cfpdfformparam name="Elder" value="#iElder#">
		<cfpdfformparam name="MinisterialServant" value="#iMinisterialServant#">
		<cfpdfformparam name="RegularPioneer" value="#iRegularPioneer#">
		<cfpdfformparam name="anointedorOther" value="#anointedOrOtherSheep#">
		
		<cfset icount = 1>
		<cfloop query="loadTime">

			<cfpdfformparam name="monthRow#icount#" value="#monthAsString(imonth)# #iYear#">
			<cfpdfformparam name="hoursRow#icount#" value="#hours#">
			<cfpdfformparam name="magsRow#icount#" value="#mags#">
			<cfpdfformparam name="booksRow#icount#" value="#books#">
			<cfpdfformparam name="rvRow#icount#" value="#rv#">
			<cfpdfformparam name="BSRow#icount#" value="#BS#">
			<cfset icount = icount + 1>		
		</cfloop>
		
</cfloop>
</cfpdfform>


<cfpdf action=write source="C:\domains\timothyCunningham\PublisherCard\PDF_Form\Pubinfo_#loadCard.lname#_#loadCard.Fname#.pdf" 
	destination="C:\domains\timothyCunningham\PublisherCard\PDF_Form\Pubinfo_#loadCard.lname#_#loadCard.Fname#.pdf"
	flatten="true"
	Overwrite="true">