<cfparam name=serviceGroupID default=17>
<cfparam name=asofMonth default="12">
<cfparam name=asofYear default="2010">


<cfquery name="load" datasource="#application.DSN#">
	SELECT publisherID, lname, fname, 
	(select groupName from serviceGroup WHERE serviceGroup.serviceGroupID = publisher.serviceGroupID) as zgroup
	FROM publisher
	WHERE serviceGroupID = #serviceGroupID#
	ORDER BY lname
</cfquery>

<cfset fileList = "">
<cfloop query="load">

	<cfinvoke component="#application.CFCPath#PublisherCard" 
			method="getCard"
			publisherID="#publisherID#"
			serviceYear="#asofYear#"
			flatten=1
			returnVariable="pdfPath">
			 
	<cfinvoke component="#application.CFCPath#PublisherCard" 
			method="flatten"
			source="#pdfPath#"
			returnVariable="pdfPath">
	<!---		
	<cfinvoke component="#application.CFCPath#PublisherCard" 
				method="makeImage"
				source="#pdfPath#"
				returnVariable="imagePath"> --->
			
	<cfset filelist = listAppend(fileList, pdfPath)>
	
		<cfinvoke component="#application.CFCPath#PublisherCard" 
			method="getCard"
			publisherID="#publisherID#"
			serviceYear="#Evaluate(asofYear-1)#"
			flatten=1
			returnVariable="pdfPath">
			 
	<cfinvoke component="#application.CFCPath#PublisherCard" 
			method="flatten"
			source="#pdfPath#"
			returnVariable="pdfPath">
			
	<!---
	<cfinvoke component="#application.CFCPath#PublisherCard" 
				method="makeImage"
				source="#pdfPath#"
				returnVariable="imagePath"> --->
			
	<cfset filelist = listAppend(fileList, pdfPath)>
	
</cfloop>
			 

<cfset groupPDF = "#Application.RootPath#\ServiceGroup\PDF\#load.zgroup#_Group_Time.pdf">
<cfpdf action="merge"
	source="#fileList#"
	destination="#groupPDF#"
	overwrite="true">
	
	
<cfcontent file="#groupPDF#">
	
