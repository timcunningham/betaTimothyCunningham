<cfquery name="loadPub" datasource="#application.DSN#">
	SELECT  *
	FROM Publisher P
	WHERE publisherID=#publisherID#
	ORDER BY lname
</cfquery>

	<cfset asofYear = datePart("yyyy", now())>
	<cfset yearList = "#evaluate(asofYear+1)#,#asOfYear#">
	
	<cfloop list="#yearList#" index="curYear">

		<cfinvoke component="#application.CFCPath#PublisherCard" 
				method="getCard"
				publisherID="#publisherID#"
				serviceYear="#curYear#"
				flatten=1
				returnVariable="pdfPath">
		
			 
		<cfinvoke component="#application.CFCPath#PublisherCard" 
				method="flatten"
				source="#pdfPath#"
				returnVariable="pdfPath">
				
		<cfinvoke component="#application.CFCPath#PublisherCard" 
					method="makeImage"
					source="#pdfPath#"
					returnVariable="imagePath">
					
	</cfloop>
				
			
<cfdirectory action="list" directory="#application.cardImagePath#" name="cardDir" filter="#loadPub.lname#_#loadPub.fname#*.jpg">

<!--- 
<cfoutput>
<cfloop query="cardDir">
	<cfset niceName = replaceNocase(name, ".pdf", "", "ALL")>
	<cfset niceName = replaceNocase(niceName, "_", " ", "ALL")>
<a href="../PublisherCard/PDF/#name#">#niceName#</a><br> 
</cfloop>
</cfoutput> --->

<cfoutput>
<cfloop query="cardDir">
	<cfset niceName = replaceNocase(name, ".jpg", "", "ALL")>
	<cfset niceName = replaceNocase(niceName, "_", " ", "ALL")>
<a href="../PublisherCard/Image/#name#">#niceName#</a><br> 
</cfloop>
</cfoutput>

<cfdirectory action="list" directory="#application.cardPDFPath#" name="cardDir" filter="#loadPub.lname#_#loadPub.fname#*.pdf">

<cfoutput>
<cfloop query="cardDir">

	<cfset niceNamePDF = name>
	<cfset niceNamePDF = replaceNocase(name, ".pdf", "", "ALL")>
	<cfset niceNamePDF = replaceNocase(niceNamePDF, "_", " ", "ALL")>
<a href="../PublisherCard/PDF/#name#">#niceNamePDF#</a><br> 
</cfloop>
</cfoutput>
