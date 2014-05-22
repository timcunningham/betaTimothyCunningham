<cfquery name="pd" datasource="tomatoIndex">
SELECT *
FROM plantingDate
WHERE getDate() BETWEEN startDate1 AND endDate1
OR getDate() BETWEEN startDate2 AND endDate2
	
</cfquery>

<cfdump var="#pd#" label="What to plant now">
<br>
<br>


<cfquery name="all" datasource="tomatoIndex">
SELECT *
FROM plantingDate
ORDER BY startDate1, startDate2
</cfquery>

<cfdump var="#all#" label="What to plant now">
<br>
<br>