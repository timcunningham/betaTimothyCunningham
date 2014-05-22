<cfparam name="anointed" default=0>
<cfparam name="othersheep" default=0>
<cfparam name="servant" default=0>
<cfparam name="elder" default=0> 
<cfparam name="pioneerschool" default=0> 
<cfparam name="pioneer" default=0> 


<cfdump var="#form#">

	<cfquery name="loadGroup" datasource="#application.DSN#">
		INSERT Publisher (fname, lname, address1, city,
			state, telephone, mobile, email, dob, dateimmersed,
			serviceGroupID, anointed, othersheep, elder, servant, gender,
			pioneerSchool, pioneerSchoolYear, pioneer, zip)
		VALUES ('#fname#', '#lname#', '#address1#', '#city#',
			'#UCASE(state)#', '#telephone#', '#mobile#','#email#', '#dob#', '#dateimmersed#',
			'#serviceGroupID#', '#int(anointed)#', '#int(othersheep)#', '#int(elder)#', '#int(servant)#',
			'#UCASE(gender)#', '#int(pioneerSchool)#', '#pioneerSchoolYear#', '#int(pioneer)#',
			'#zip#')
	</cfquery>



<cflocation url="default.cfm">