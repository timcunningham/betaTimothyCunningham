<cfparam name="anointed" default=0>
<cfparam name="othersheep" default=0>
<cfparam name="elder" default=0>
<cfparam name="servant" default=0>
<cfparam name="gender" default="F">
<cfparam name="pioneer" default=0>
<cfparam name="specialPioneer" default=0>
<cfparam name="cardTransferedOut" default=0>
<cfparam name="infirmPio" default=0>

<cfquery name="publisher" datasource="#application.DSN#">
	UPDATE publisher
	SET fname='#fname#',
		lname='#lname#',
		address1='#address1#',
		city='#city#',
		state='#state#',
		zip='#zip#',
		telephone='#telephone#',
		mobile='#mobile#',
		email='#email#',
		dob='#dob#',
		dateimmersed='#dateimmersed#',
		serviceGroupID=#serviceGroupID#,
		anointed=#anointed#,
		othersheep=#otherSheep#,
		elder=#elder#,
		servant='#servant#',
		gender='#gender#',
		pioneer=#pioneer#,
		specialPioneer=#specialPioneer#,
		cardTransferedOut=#cardTransferedOut#
	WHERE publisherID = #publisherID#
</cfquery>

<cfoutput>
	
	<a href="publisher.cfm?publisherID=#publisherID#">Return to #fname# #lname# info</a>
	&nbsp;&nbsp;
	<a href="../publishercard/publisherList.cfm">Publisher List</a>
	
</cfoutput>
