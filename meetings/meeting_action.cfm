<cfdump var="#form#">




<cfloop from=1 to=5 index=i>
	<cfquery name="loadSun" datasource="#application.DSN#">
		SELECT *
		FROM meetingAttendance
		WHERE imonth=#imonth#
		AND iYear=#iYear#
		AND iweek=#i#
		AND meetingType = 'SUN'
	</cfquery>
	<cfdump var="#loadSun#">

	<cfquery name="loadTues" datasource="#application.DSN#">
		SELECT *
		FROM meetingAttendance
		WHERE imonth=#imonth#
		AND iYear=#iYear#
		AND iweek=#i#
		AND meetingType = 'Tues'
	</cfquery>
	<cfif loadSun.recordCount IS 0 AND evaluate("SUN_#i#") NEQ "">
		<cfquery datasource="#application.DSN#">
			Insert meetingAttendance (iweek,imonth,iyear,meetingType,meetingAttendance)
			VALUES(#i#, #imonth#,#iyear#,'SUN','#evaluate("SUN_#i#")#')
		</cfquery> 
	</cfif>
	
	<cfif loadTues.recordCount IS 0 AND evaluate("TUES_#i#") NEQ "">
		<cfquery datasource="#application.DSN#">
			Insert meetingAttendance (iweek,imonth,iyear,meetingType,meetingAttendance)
			VALUES(#i#, #imonth#,#iyear#,'TUES','#evaluate("TUES_#i#")#')
		</cfquery> 
	</cfif>
	
	<cfif loadSun.recordCount GT 0 AND evaluate("SUN_#i#") NEQ "">
		<cfquery datasource="#application.DSN#">
			UPDATE meetingAttendance
			SET meetingAttendance = #evaluate("SUN_#i#")#
			WHERE iweek=#i#
			AND imonth=#imonth#
			AND iyear=#iYear#
			AND meetingType = 'SUN'
		</cfquery> 
		</cfif>
		
		<cfif loadTues.recordCount GT 0 AND evaluate("TUES_#i#") NEQ "">
			<cfquery datasource="#application.DSN#">
				UPDATE meetingAttendance
				SET meetingAttendance = #evaluate("TUES_#i#")#
				WHERE iweek=#i#
				AND imonth=#imonth#
				AND iyear=#iYear#
				AND meetingType = 'TUES'
			</cfquery>
		</cfif>
		
</cfloop>



<cflocation url="default.cfm?imonth=#imonth#&iyear=#iyear#">