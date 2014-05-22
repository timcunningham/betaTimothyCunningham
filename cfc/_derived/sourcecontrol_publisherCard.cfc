<!---
TomatoIndex
Controls the publisherCard object
Written by Timothy Cunningham for tomatoIndex.com
--->


<cfcomponent displayname="publisherCard" hint="publisherCard Handling">

<cfset this.DSN = application.DSN>
<cfset instance.documentedAccessLevels = "remote,public"> 	
<cfinclude template="./CFCRemoteDocumenter.cfm">

<!--- ******************************************************** --->
<!--- ******************	getCard 	********************** --->
<!--- ******************************************************** --->
<cffunction name="getCard" access="remote">
	<cfargument name="publisherID" type="numeric" required="true">
	<cfargument name="serviceYear" type="numeric" required="true">
	<cfargument name="flatten" type="numeric" required="false">
	
	
	<cfif flatten IS "" OR flatten IS 0>
		<cfset flatten = "NO">
	<cfelse>
		<cfset flatten = "Yes">
	</cfif>
	

	<cfquery name="loadPub" datasource="#this.DSN#">
		SELECT *
		FROM publisher WITH (NOLOCK)
		WHERE publisherID =  <cfqueryparam value = "#publisherID#" cfsqltype = "cf_sql_integer">
	</cfquery>
	
	<cfset variables.pdfPath = "#Application.RootPath#\PublisherCard\">
	<cfset variables.pdfFile = "publisherCard.pdf">
	<cfset variables.destination = "#Application.RootPath#PublisherCard\PDF\#loadPub.lname#_#loadPub.fname#_#serviceYear#.pdf">

	<cfpdfform action="populate" source="#pdfPath##pdfFile#" destination="#variables.destination#"
		overwrite="True">
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
			SELECT *, dbo.runningAvg(serviceReportID) as runningAVG
			FROM ServiceReport
			WHERE publisherID = #publisherID#
				AND serviceYear  = '#serviceYear#'
				AND submittedToBranch=1
		</cfquery>

		<cfquery name="loadTots" datasource="#application.DSN#">
			SELECT sum(books) as booksTotal, 
				sum(brochure) as brochureTotal,
				sum(hours) as hoursTotal,
				sum(mags) as magsTotal,
				sum(rv) as rvTotal,
				sum(bs) as BSTotal,
				Convert(decimal, avg(hours)) as avgHours
			FROM ServiceReport
			WHERE publisherID = #publisherID#
				AND serviceYear  = '#serviceYear#'
				AND submittedToBranch=1
				---AND hours > 0
				AND hours IS NOT NULL
		</cfquery>
		
		<cfloop query="loadCard">
			<cfset auxRemark ="">
			<cfif aux IS True>
				<cfset auxRemark = "AUX">
			</cfif>
			<cfset rbcRemark = "">
			<cfif rbc GT 0>
				<cfset rbcremark = "RBC:#RBC#">
			</cfif>
			<cfpdfformparam name="Books_#iMonth#" value="#books#">
			<cfpdfformparam name="Brochure_#iMonth#" value="#Brochure#">
			<cfpdfformparam name="Hours_#iMonth#" value="#Hours#">
			<cfpdfformparam name="Mags_#iMonth#" value="#Mags#">
			<cfpdfformparam name="RV_#iMonth#" value="#RV#">
			<cfpdfformparam name="BS_#iMonth#" value="#BS#">
			<cfpdfformparam name="Remarks_#iMonth#" value="#Remarks# (6mo avg:#numberformat(runningAVG, "999.9")#) #rbcRemark# #AuxRemark#">
			
		</cfloop>
		
		<cfloop query="loadTots">
			<cfpdfformparam name="BooksTotal" value="#booksTotal#">
			<cfpdfformparam name="brochureTotal" value="#brochureTotal#">
			<cfpdfformparam name="hoursTotal" value="#hoursTotal#">
			<cfpdfformparam name="magsTotal" value="#magsTotal#">
			<cfpdfformparam name="rvTotal" value="#rvTotal#">
			<cfpdfformparam name="BSTotal" value="#BSTotal#">
			<cfpdfformparam name="Remarks_Total" value="Year AVG: #numberformat(avgHours, "9999.9")#">
			
		</cfloop>
		
		
	</cfloop>
	</cfpdfform>

	
	<cfreturn variables.destination>
</cffunction>

<cffunction name="flatten" access="remote">
	<cfargument name="source" type="string" required="true">
	
	<cfpdf action="write" destination=#source# source="#source#"
		flatten="yes" overwrite="yes">	
		
	<cfreturn source>

</cffunction>

<cffunction name="makeImage" access="remote">
	<cfargument name="source" type="string" required="true">
	<cfset newFilePath = replaceNoCase(source, "\PDF\", "\image\")>
	<cfset filename  = listLast(newFilePath, "\")>
	<cfset newFilePath = replaceNoCase(newFilePath, filename, "")>
	<cfset filename = replaceNoCase(fileName, ".pdf", "")>
	<cfset jpgPath = "">
	
	<cfpdf action="getinfo" source="#source#" name="pdfInfo">
	<cfset pagecount=pdfInfo.TotalPages> 
	
	<Cfpdf action="thumbnail"  overwrite=true 
	source="#source#" destination="#newFilePath#"
	format="jpg" maxscale=100 maxlength=2000 maxbreadth=2000 
	hires=yes scale=100>

	<cfloop index="LoopCount" from="1" to="#pageCount#" step="1">
		<cffile action=rename source="#newFilePath##fileName#_page_#loopCount#.jpg" destination="#newFilePath##fileName#.jpg">
		<cfset  jpgPath = listAppend(jpgPath, "#newFilePath##fileName#.jpg")>
	</cfloop>

	<cfreturn jpgPath>

</cffunction>



</cfcomponent>	