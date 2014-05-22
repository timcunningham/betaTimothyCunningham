<!---
TomatoIndex
Controls the serviceGroup object
Written by Timothy Cunningham for tomatoIndex.com
--->


<cfcomponent displayname="serviceReport" hint="serviceReport Handling">

<cfset this.DSN = application.DSN>
<cfset instance.documentedAccessLevels = "remote,public"> 	
<cfinclude template="./CFCRemoteDocumenter.cfm">

<!--- ******************************************************** --->
<!--- ******************	Init New Month 	****************** --->
<!--- ******************************************************** --->

<cffunction name="initMonth" access="remote">
	<cfargument name="imonth"  required="true">
	<cfargument name="iYear" required="true">
	<cfargument name="serviceYear"  required="true">
	
	<cfset var check = "">
	<cfquery  datasource="#application.DSN#">
		INSERT INTO serviceReport(publisherID, ServiceGroupID, lname, fname, iYear, iMonth, regPioneer, serviceYear, submittedToBranch, specialPioneer)
		SELECT  publisherID, ServiceGroupID, lname, fname, #iYear#, #imonth#, pioneer, #serviceYear#, 0, specialPioneer
		FROM publisher
		WHERE cardTransferedOut = 0 
		AND serviceGroupID > 9
	</cfquery>
	
	<cfquery name="check" datasource="#application.DSN#">
		SELECT count(*) as insertCount
		FROM serviceReport
		WHERE iYear = #iYear#
			AND imonth= #imonth#
			AND serviceYear = #iYear#
			AND submittedToBranch=0
	</cfquery>
	
	<cfreturn check.insertCount>
</cffunction>

<cffunction name="submitToBranch" access="remote">
	<cfset var check = "">
	<cfquery name="check" datasource="#application.DSN#">
		SELECT fname,lname,hours
		FROM serviceReport
		WHERE submittedToBranch=0
		AND hours > 0
	</cfquery>
	
	<cfquery  datasource="#application.DSN#">
		UPDATE serviceReport
		SET submittedToBranch=1,
		dateSubmittedtothebranch=getDate()
		WHERE submittedToBranch=0
		AND hours > 0
	</cfquery>
	
	<cfdump var="#check#" label="Effected Publishers">
	<cfreturn "Done">
</cffunction>



</cfcomponent>	