<!---
TomatoIndex
Controls the serviceGroup object
Written by Timothy Cunningham for tomatoIndex.com
--->


<cfcomponent displayname="serviceGroup" hint="serviceGroup Handling">

<cfset this.DSN = application.DSN>
<cfset instance.documentedAccessLevels = "remote,public"> 	
<cfinclude template="./CFCRemoteDocumenter.cfm">

<!--- ******************************************************** --->
<!--- ******************	 dfd	********************** --->
<!--- ******************************************************** --->

<cffunction name="makeImage" access="remote">
	<cfargument name="source" type="string" required="true">
	<cfset newFilePath = replaceNoCase(source, ".PDF", ".jpg")>
	<cfset newFilePath = replaceNoCase(newFilePath, "\PDF\", "\image\")>
	
	<cfset dqt = chr(34)>
	<cfset executablePath ="C:\PDF-IMAGE\ConvertPDFtoImage.exe">
	<cfset strCmd = " /S #dqt##source##dqt# /C1 /T #dqt##newFilePath##dqt# /1 * /4 100 /5 200">

	<cfexecute name = "#executablePath#"
		arguments = "#strCmd#"
	   timeout = "20">
	</cfexecute>


	<cfreturn source>

</cffunction>



</cfcomponent>	