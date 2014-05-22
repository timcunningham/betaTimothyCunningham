<cfquery name="all" datasource="#application.DSN#">
	UPDATE publisher
	SET email =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.email#">
	WHERE PublisherID =  <cfqueryparam cfsqltype="cf_sql_integer" value="#form.publisherID#">
</cfquery>
<cflocation url="publisherEmail.cfm">
