<cfquery name="load" datasource="#application.DSN#">
	SELECT publisherID, lname, fname, 
	(select groupName from serviceGroup WHERE serviceGroup.serviceGroupID = publisher.serviceGroupID) as zgroup
	FROM publisher
	ORDER BY lname
</cfquery>

<cfdump var="#load#">