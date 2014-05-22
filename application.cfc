<cfcomponent>
<cfset This.name = "beta.TimothyCunningham">
<cfset This.Sessionmanagement=true>
<cfset This.Sessiontimeout="#createtimespan(0,0,10,0)#">
<cfset This.applicationtimeout="#createtimespan(5,0,0,0)#">


<cffunction name="onApplicationStart">
	<cfsetting showdebugoutput=NO>
	<cfset application.DSN = "TimothyCunningham">
	<cfset application.CFCPath = "TimothyCunninghamRoot/cfc/">
	<cfset application.ActionPath = "/TimothyCunninghamRoot/action/">
	<cfset application.imagePath = "/TimothyCunninghamRoot/images/">
	<cfset application.cardImagePath = "C:\Domains\timothyCunningham\PublisherCard\Image">
	<cfset application.cardPDFPath = "C:\Domains\timothyCunningham\PublisherCard\PDF">
   <cftry>
      <!--- Test whether the DB that this application uses is accessible 
            by selecting some data. --->
      <cfquery name="testDB" dataSource="#application.DSN#" maxrows="2">
         SELECT tomatoID FROM tomato
      </cfquery>
      <!--- If we get database error, report it to the user, log the error
         information, and do not start the application. --->
      <cfcatch type="database">
         <cfoutput>
            This application encountered a database initialization error.<br>
            Please contact the System Administrator.
         </cfoutput>
         <cflog file="#This.Name#" type="error" 
            text="TimothyCunningham DB not available. message: #cfcatch.message# 
            Detail: #cfcatch.detail# Native Error: #cfcatch.NativeErrorCode#">
         <cfreturn False>
      </cfcatch>
   </cftry>
   <cflog file="#This.Name#" type="Information" text="Application Started">
   <!--- You do not have to lock code in the onApplicationStart method that sets Application scope variables. --->
   <cfscript>
      Application.availableResources=0;
      Application.counter1=1;
      Application.sessions=0;
      Application.DSN="TimothyCunningham";
      Application.RootPath ="C:\Domains\timothyCunningham\";
   </cfscript>
   <!--- You do not need to return True if you don't set the cffunction returntype attribute. --->
 </cffunction>

<cffunction name="onApplicationEnd">
   <cfargument name="ApplicationScope" required=true/>
   <cflog file="#This.Name#" type="Information" 
      text="Application #ApplicationScope.applicationname# Ended">
</cffunction>


<cffunction name="onRequestStart"> 
	<cfsetting showdebugoutput=NO>
   <!--- Authentication code, makes sure that a user is logged in, 
   and if not displays a login page. --->
  
<!--- If it's time for maintenance, tell users to come back later. --->
   <cfscript>
      if ((Hour(now()) gt 1) and (Hour(now()) lt 3)) {
         WriteOutput("The system is undergoing periodic maintenance. 
            Please return after 3:00 AM Eastern time.");
         return false;
      } else {
         this.start=now();
      }
   </cfscript>
   
   <cfif structKeyExists(url, "refreshmebabyonemoretime")>
		<cfset onApplicationStart()>
	</cfif>
   
   <cfif structKeyExists(url, "refreshmebabyonemoretime")>
		<cfset onApplicationStart()>
	</cfif>
	
	<cfset request.FCKeditor = StructNew()>
<cfset request.FCKeditor.userFilesPath = "/Uploaded/">
	
	
<!--- Coldfusion MX will pass a variable as a list if it find more than on URLParam with
the same name this code ensures there is only one variable with that name --->
<cfset queryString = CGI.QUERY_STRING>

<cfset queryString = replaceNoCase(queryString, "?", "&", "ALL")>
<cfloop list="#queryString#" index="curPair" delimiters="&">
	<cfif findNoCase("=", curPair)>
		<cfset varName = mid(curPair, 1, findNoCase("=", curPair)-1)>
		<cfset varValue = mid(curPair, findNoCase("=", curPair)+1, len(curPair))>
		<cfset varValue = URLDecode(varValue)>
	</cfif>
	
	<CFSET Result=SetVariable("#varName#", "#varValue#")>
	
 <!--- LOGGING HISTORY
 Turned on:	2/23/2005 1:40PM - TJC --->

<cfif ISDefined("Session.UID")>
	<cfset tempUID = Session.UID>
<cfelse>
	<cfset tempUID = 0>
</cfif>

<cfquery name="debugPageLog_1" datasource="#application.DSN#">
	BEGIN TRANSACTION
	SET NOCOUNT ON
			
	INSERT DebugPageLog (pageName, UserID, URLParam, IP)
	VALUES ('#left(CGI.SCRIPT_NAME, 500)#', #tempUID#, '#left(CGI.QUERY_STRING, 3000)#', '#CGI.REMOTE_ADDR#')
		
	SET NOCOUNT OFF
	SELECT SCOPE_IDENTITY() AS 'debugPageLogID'
	COMMIT TRANSACTION
</cfquery>
<cfset Session.debugPageLogID = debugPageLog_1.debugPageLogID>
</cfloop>

</cffunction>

<!--- This is a minimal example of an onRequest filter. 
<cffunction name="onRequest">
   <cfargument name = "targetPage" type="String" required=true/>
   <cfsavecontent variable="content">
      <cfinclude template=#Arguments.targetPage#>
   </cfsavecontent>
   
   <cfoutput>
      #replace(content, "report", "MyCompany Quarterly Report", "all")#
   </cfoutput>
</cffunction>--->


<cffunction name="onRequestEnd">
	<cfif isDefined("session.debugPageLogID")>
		<cfquery  datasource="#application.DSN#">
		UPDATE debugpageLog
		SET endTime = getDate(),
		processingTime = Datediff(ms, startTime, getDate())
		WHERE debugPageLogID = #session.debugPageLogID#	
		</cfquery>
	</cfif>
</cffunction>



<cffunction name="onSessionStart">
   <cfscript>
      Session.started = now();
      Session.shoppingCart = StructNew();
      Session.shoppingCart.items =0;
   </cfscript>
   <cflock timeout="5" throwontimeout="No" type="EXCLUSIVE" scope="SESSION">
      <cfset Application.sessions = Application.sessions + 1>
   </cflock>
   <cflog file="#This.Name#" type="Information" text="Session:      #Session.sessionid# started">
</cffunction>

<cffunction name="onSessionEnd">
   <cfargument name = "SessionScope" required=true/>
   <cflog file="#This.Name#" type="Information" text="Session:      #arguments.SessionScope.sessionid# ended">
</cffunction>

<!--- 
<cffunction name="onError">
   <cfargument name="Exception" required=true/>
   <cfargument type="String" name = "EventName" required=true/>
  
   <cflog file="#This.Name#" type="error" text="Event Name: #Eventname#">
   <cflog file="#This.Name#" type="error" text="Message: #exception.message#">

   <cfif isdefined("exception.rootcause")>
      <cflog file="#This.Name#" type="error" 
         text="Root Cause Message: #exception.rootcause.message#">
   </cfif>   

   <cfif NOT (Arguments.EventName IS onSessionEnd) OR 
         (Arguments.EventName IS onApplicationEnd)>
      <cfoutput>
         <h2>An unexpected error occurred.</h2>
         <p>Please provide the following information to technical support:</p>
         <p>Error Event: #EventName#</p>
         <p>Error details:<br>
         <cfdump var=#exception#></p>
      </cfoutput>
   </cfif>
 </cffunction> --->

</cfcomponent>
