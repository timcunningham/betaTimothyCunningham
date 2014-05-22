<cfdump var="#form#">


<cfquery  datasource="#application.DSN#">
	UPDATE publisher
	SET serviceGroupID = '#serviceGroupID#'
	WHERE PublisherID =  '#loadALLPubs#'
</cfquery>


<cflocation url="default.cfm?serviceGroupID=#serviceGroupID#">