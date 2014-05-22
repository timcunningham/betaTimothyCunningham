<cfquery name="pd" datasource="tomatoIndex">
SELECT *
FROM plantingDate
WHERE getDate() BETWEEN startDate1 AND endDate1
OR getDate() BETWEEN startDate2 AND endDate2
	
</cfquery>

<cfdump var="#pd#" label="What to plant now">