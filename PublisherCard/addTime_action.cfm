<cfdump var="#form#">
<cfdump var="#URL#">


<cfif actionType IS "Insert">
	<cfquery datasource="#application.DSN#">
		INSERT INTO ServiceReport
		(publisherID, ServiceGroupID, lname, fname, 
		iYear, iMonth, books, brochure, hours, 
		mags, RV, BS, RBC, aux, regPioneer, 
		unbapt, remarks, temp, serviceYear, minute, specialPioneer,submittedToBranch)
		VALUES('#publisherID#', '#ServiceGroupID#', '#lname#', '#fname#', 
		'#iYear#', '#iMonth#', '#books#', '#brochure#', '#hours#', 
		'#mags#', '#RV#', '#BS#', '#RBC#', '#aux#', '#regPioneer#', 
		'#unbapt#', '#remarks#', 0, '#serviceYear#', '#minute#',#specialPioneer#,#submittedToBranch#)
	</cfquery>
</cfif>


<cfif actionType IS "Update">
	<cfquery datasource="#application.DSN#">
		UPDATE ServiceReport
		SET 	serviceGroupID = '#serviceGroupID#',
			lname = '#lname#',
			fname = '#fname#',
			Iyear = '#iYear#',
			iMonth = '#iMonth#',
			books = '#books#',
			brochure = '#Brochure#',
			hours = '#Hours#',
			mags = '#Mags#',
			rv = '#Rv#',
			bs = '#bs#',
			RBC = '#RBC#',
			aux = '#Aux#',
			regPioneer = '#RegPioneer#',
			unbapt = '#Unbapt#',
			remarks = '#remarks#',
			minute='#minute#',
			serviceYear = '#ServiceYear#',
			specialPioneer = #specialPioneer#,
			submittedToBranch=#submittedToBranch#
		WHERE serviceYear = '#ServiceYear#'
			AND iMonth = '#iMonth#'
			AND publisherID = '#publisherID#'
	</cfquery>

	<cfquery datasource="#application.DSN#">
		UPDATE publisher
		SET 	CARDTRANSFEREDOUT= '#CARDTRANSFEREDOUT#',
			telephone='#telephone#',
			mobile='#mobile#'
		WHERE publisherID = '#publisherID#'
	</cfquery>

<cfoutput>
<pre>
UPDATE ServiceReport
		SET publisherID = '#publisherID#',
			serviceGroupID = '#serviceGroupID#',
			lname = '#lname#',
			fname = '#fname#',
			Iyear = '#iYear#',
			iMonth = '#iMonth#',
			books = '#books#',
			brochure = '#Brochure#',
			hours = '#Hours#',
			mags = '#Mags#',
			bs = '#bs#',
			rv = '#Rv#',
			RBC = '#RBC#',
			aux = '#Aux#',
			regPioneer = '#RegPioneer#',
			unbapt = '#Unbapt#',
			remarks = '#remarks#',
			minute = '#minute#',
			serviceYear = '#ServiceYear#'
		WHERE serviceYear = '#ServiceYear#'
			AND iMonth = '#iMonth#'
			AND publisherID = '#publisherID#'
</pre>
</cfoutput>
</cfif>

<cfoutput>
<a href="addTime.cfm?serviceYear=#ServiceYear#&imonth=#iMonth#&publisherID=#publisherID#&IYear=#iYear#">continue</a>
</cfoutput>

<cflocation url="addTime.cfm?serviceYear=#ServiceYear#&imonth=#iMonth#&publisherID=#publisherID#&IYear=#iYear#" addtoken=No>
