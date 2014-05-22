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
			<cfif iDate LT "1/1/1901">
				<cfset iDate = "">
			</cfif>
		</cfif>
		
		<cfset iDOB = dob>
		<cfif ISDate(iDOB)>
			<cfset iDOB = dateformat(iDOB, "mm/dd/yyyy")>
			<cfif iDOB LT "1/1/1901">
				<cfset iDOB = "">
			</cfif>
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
				sum(rbc) as RBCTotal,
				--Convert(decimal, avg(hours)) as avgHours,
				avg(convert(decimal, hours)) as avgHours,
				Convert(decimal, avg(hours+rbc))as avgHoursandRBC
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
			<cfpdfformparam name="Remarks_#iMonth#" value="(6mo avg:#numberformat(runningAVG, "999.9")#) #Remarks# #rbcRemark# #AuxRemark#">
			
		</cfloop>
		
		<cfloop query="loadTots">
			<cfpdfformparam name="BooksTotal" value="#booksTotal#">
			<cfpdfformparam name="brochureTotal" value="#brochureTotal#">
			<cfpdfformparam name="hoursTotal" value="#hoursTotal#">
			<cfpdfformparam name="magsTotal" value="#magsTotal#">
			<cfpdfformparam name="rvTotal" value="#rvTotal#">
			<cfpdfformparam name="BSTotal" value="#BSTotal#">
			<cfset strRBC = "">
			<cfif RBCTotal GT 0>
				<cfset strRBC = "w/RBC (#numberformat(avgHoursandRBC, "9999.9")#)">
			</cfif>
			<cfpdfformparam name="Remarks_Total" value="Year AVG: #numberformat(avgHours, "9999.9")# #strRBC#"  >
			
		</cfloop>
		
		
	</cfloop>
	</cfpdfform>

	<cfpdf action="write" destination=#destination# source="#destination#"
		 overwrite="yes" encodeAll="yes">
		
	<cfpdf action = "optimize"  destination=#destination# source="#destination#" overwrite="yes" NOJAVASCRIPTS 
    noThumbnails 
    noBookmarks 
    noComments 
    noMetadata 
    noAttachments 
    noLinks 
    nofonts>
		
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
	<cfargument name="scale" type="numeric" required="false" default=35>
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
	hires=yes scale="#arguments.scale#">

	<cfloop index="LoopCount" from="1" to="#pageCount#" step="1">
		<cffile action=rename source="#newFilePath##fileName#_page_#loopCount#.jpg" destination="#newFilePath##fileName#.jpg">
		<cfset  jpgPath = listAppend(jpgPath, "#newFilePath##fileName#.jpg")>
	</cfloop>

	<cfreturn jpgPath>

</cffunction>




<!--- ******************************************************** --->
<!--- ******************	get2CardPage 	********************** --->
<!--- ******************************************************** --->
<cffunction name="get2CardPage" access="remote">
	<cfargument name="arrayPublisherID" type="array" required="true">
	<cfargument name="arrayServiceYear" type="array" required="true">
	<cfargument name="fileOutName" type="string" required="True">
	<cfargument name="flatten" type="numeric" required="false">
	
	
	<cfif flatten IS "" OR flatten IS 0>
		<cfset flatten = "NO">
	<cfelse>
		<cfset flatten = "Yes">
	</cfif>
	
	<cfset variables.pdfPath = "#Application.RootPath#\PublisherCard\">
	
	<cfset variables.pdfFile = "publisherCard-2page.pdf">
	<cfset variables.pdfFile = "publisherCard-2page-Avery-5889.pdf">
	
	<cfset variables.destination = "#Application.RootPath#PublisherCard\PDF2page\#fileOutName#.pdf">

	<cfpdfform action="populate" source="#pdfPath##pdfFile#" destination="#variables.destination#"
		overwrite="True">
	
	<cfloop from=1 to=2 index="i">
		<cfset publisherID = arrayPublisherID[i]>
		<cfset serviceYear = arrayServiceYear[i]>
		<cfquery name="loadPub" datasource="#this.DSN#">
		SELECT *
		FROM publisher WITH (NOLOCK)
		WHERE publisherID =  <cfqueryparam value = "#publisherID#" cfsqltype = "cf_sql_integer">
	</cfquery>
	
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
			<cfif iDate LT "1/1/1901">
				<cfset iDate = "">
			</cfif>
		</cfif>
		
		<cfset iDOB = dob>
		<cfif ISDate(iDOB)>
			<cfset iDOB = dateformat(iDOB, "mm/dd/yyyy")>
			<cfif iDOB LT "1/1/1901">
				<cfset iDOB = "">
			</cfif>
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
		
	
		<cfpdfformparam name="C#i#_name" value="#lname#, #fname#">
		<cfpdfformparam name="C#i#_address" value="#address1# #city#, #state# #zip#">
		<cfpdfformparam name="C#i#_HomePhone" value="#telephone#">
		<cfpdfformparam name="C#i#_Mobile" value="#mobile#">
		<cfpdfformparam name="C#i#_male" value="#male#">
		<cfpdfformparam name="C#i#_female" value="#female#">
		<cfpdfformparam name="C#i#_DOB" value="#iDOB#">
		<cfpdfformparam name="C#i#_DateImmersed" value="#iDate#">
		<cfpdfformparam name="C#i#_Elder" value="#iElder#">
		<cfpdfformparam name="C#i#_MinisterialServant" value="#iMinisterialServant#">
		<cfpdfformparam name="C#i#_RegularPioneer" value="#iRegularPioneer#">
		<cfpdfformparam name="C#i#_anointedOthersheep" value="#anointedOrOtherSheep#">
		<cfpdfformparam name="C#i#_year" value="#evaluate(serviceYear-1)#/#serviceYear#">
		
		<cfquery name="loadCard" datasource="#application.DSN#">
			SELECT *, dbo.runningAvg(serviceReportID) as runningAVG
			FROM ServiceReport
			WHERE publisherID = #publisherID#
				AND serviceYear  = '#serviceYear#'
				---AND submittedToBranch=1
		</cfquery>

		<cfquery name="loadTots" datasource="#application.DSN#">
			SELECT sum(books) as booksTotal, 
				sum(brochure) as brochureTotal,
				sum(hours) as hoursTotal,
				sum(mags) as magsTotal,
				sum(rv) as rvTotal,
				sum(bs) as BSTotal,
				sum(rbc) as RBCTotal,
				Convert(decimal, avg(hours)) as avgHours,
				Convert(decimal, avg(hours+rbc))as avgHoursandRBC
			FROM ServiceReport
			WHERE publisherID = #publisherID#
				AND serviceYear  = '#serviceYear#'
				---AND submittedToBranch=1
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
			<cfpdfformparam name="C#i#_Books_#iMonth#" value="#books#">
			<cfpdfformparam name="C#i#_Brochure_#iMonth#" value="#Brochure#">
			<cfpdfformparam name="C#i#_Hours_#iMonth#" value="#Hours#">
			<cfpdfformparam name="C#i#_Mags_#iMonth#" value="#Mags#">
			<cfpdfformparam name="C#i#_RV_#iMonth#" value="#RV#">
			<cfpdfformparam name="C#i#_BS_#iMonth#" value="#BS#">
			<cfpdfformparam name="C#i#_Remarks_#iMonth#" value="(6mo avg:#numberformat(runningAVG, "999.9")#) #Remarks# #rbcRemark# #AuxRemark#">
			
		</cfloop>
		
<!---
		<cfloop query="loadTots">
			<cfpdfformparam name="C#i#_BooksTotal" value="#booksTotal#">
			<cfpdfformparam name="C#i#_brochureTotal" value="#brochureTotal#">
			<cfpdfformparam name="C#i#_hoursTotal" value="#hoursTotal#">
			<cfpdfformparam name="C#i#_magsTotal" value="#magsTotal#">
			<cfpdfformparam name="C#i#_rvTotal" value="#rvTotal#">
			<cfpdfformparam name="C#i#_BSTotal" value="#BSTotal#">
			<cfset strRBC = "">
			<cfif RBCTotal GT 0>
				<cfset strRBC = "w/RBC (#numberformat(avgHoursandRBC, "9999.9")#)">
			</cfif>
			<cfpdfformparam name="C#i#_RemarksTotal" value="Year AVG: #numberformat(avgHours, "9999.9")# #strRBC#"  >
			
		</cfloop> --->
		
		
	</cfloop>
		
		
	
	</cfloop>

	
	</cfpdfform>

	<cfif flatten IS "YES">
		
	<cfpdf action="write" destination=#variables.destination# source="#variables.destination#"
		flatten="yes" overwrite="yes"  encodeAll="yes">	
	</cfif>	
	
		
	<cfpdf action = "optimize"  destination=#destination# source="#destination#" overwrite="yes" NOJAVASCRIPTS 
    noThumbnails 
    noBookmarks 
    noComments 
    noMetadata 
    noAttachments 
    noLinks 
    nofonts>
	<cfreturn variables.destination>
</cffunction>


</cfcomponent>	