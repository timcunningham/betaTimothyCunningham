<!doctype html>
<html>
 <body>

<cfparam name="iMonth" 	default	=	"#datepart("m", now())#">
<cfparam name="iYear"	default	=	"#datepart("yyyy", now())#">

<cfset priorMonth = dateAdd("m" ,-1,"#imonth#/1/#iYear#")>
<cfset nextMonth = dateAdd("m" ,1,"#imonth#/1/#iYear#")>


<cfset priorIMonth = datePart("m", priorMonth)>
<cfset nextIMonth = datePart("m", NextMonth)>
<cfset priorIYear = datePart("yyyy", priorMonth)>
<cfset nextIYear = datePart("yyyy", NextMonth)>

<cfset tues_1 = "">
<cfset sun_1 = "">
<cfset tues_2="">
<cfset sun_2="">
<cfset tues_3="">
<cfset sun_3="">
<cfset tues_4="">
<cfset sun_4="">
<cfset tues_5="">
<cfset sun_5="">
<cfset tues_count="">
<cfset tues_tot="">
<cfset tues_avg="">
<cfset sun_count="">
<cfset sun_tot="">
<cfset sun_avg="">

<cfquery name="loadMonth" datasource="#application.DSN#">
	SELECT *
	FROM meetingAttendance
	WHERE imonth = '#imonth#'
	AND iyear = '#iYear#'
</cfquery>

<cfquery name="tots" datasource="#application.DSN#">
	SELECT sum(meetingAttendance) as total, avg(meetingAttendance) as average, count(*) as meetingCount, meetingType
	FROM meetingAttendance
	WHERE imonth = '#imonth#'
	AND iyear = '#iYear#'
	AND meetingAttendance > 0
	GROUP BY meetingType
</cfquery>
 
<cfloop query="tots">
	<cfset "#tots.meetingType#_Tot" = tots.total>
	<cfset "#tots.meetingType#_AVG" = tots.average>	
	<cfset "#tots.meetingType#_Count" = tots.meetingCount>	
</cfloop>

<cfloop query="loadMonth">
	<cfset "#loadMonth.meetingType#_#loadMonth.iWeek#" = meetingAttendance>
</cfloop>

<cfoutput>
<form action="meeting_action.cfm" method=Post>
<table cellpadding="10" border="2">
<tr>
	<td colspan="10">
	<center><h1>Attendance for #iMonth#/#iYear#
	</h1>
	</center>
	</td>
</tr>
<tr>
	<td>Meeting</td>
	<td>1st Wk</td>
	<td>2nd Wk</td>
	<td>3rd Wk</td>
	<td>4th Wk</td>
	<td>5th Wk</td>
	<td>## Mtgs</td>
	<td>Total</td>
	<td>Avg</td>
</tr>
<tr>
	<td>Tues</td>
	<cfloop from=1 to=5 index=i>
	<td><input name="Tues_#i#" value="#evaluate("TUES_#i#")#" size=3 maxlength=3></td>
	</cfloop>
	<td>#tues_count#</td>
	<td>#tues_tot#</td>
	<td>#tues_avg#</td>
</tr>
<tr>
	<td>Sun</td>
	<cfloop from=1 to=5 index=i>
	<td><input name="SUN_#i#" value="#evaluate("SUN_#i#")#" size=3 maxlength=3></td>
	</cfloop>
	<td>#sun_count#</td>
	<td>#sun_tot#</td>
	<td>#sun_avg#</td>
</tr>
<tr>
	<td colspan="10">
	<center><input type="submit">
	<input type="hidden" name="imonth" value="#imonth#">
	<input type="hidden" name="iyear" value="#iYear#">
	</center>
	</td>
</tr>
<tr border="0">
	<td>
		<a href="default.cfm?imonth=#priorIMonth#&iyear=#priorIyear#">Last Month</a>
	</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>
		<a href="default.cfm?imonth=#nextIMonth#&iyear=#nextIyear#">Next Month</a>
	</td>	

	
</tr>
</form>

</cfoutput>

</body>
</html>