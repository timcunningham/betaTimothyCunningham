<cfset dataStruct = structNew()>
<cfset datastruct.vehicleNumber = 1>
<cfset datastruct.VehicleYear = 2009>
<cfset datastruct.Make = "FORD">
<cfset datastruct.Model = "EDGE SE">
<cfset datastruct.BodyType = "SUV">
<cfset datastruct.VIN = "2FM&K36C&91111111">
<cfset datastruct.Vinstate = "TN">
<cfset qryData = queryNew("VehicleNumber, VehicleYear, Make, Model, BodyType,VIN,Vinstate", "Integer,Integer,varchar,varchar,varchar,varchar,varchar")>

<cfset temp = queryAddRow(qryData)>
<cfset temp = QuerySetCell(qryData, "VehicleNumber", 1)>
<cfset temp = QuerySetCell(qryData, "VehicleYear", 2009)>
<cfset temp = QuerySetCell(qryData, "Make", "FORD")>
<cfset temp = QuerySetCell(qryData, "Model", "EDGE SE")>
<cfset temp = QuerySetCell(qryData, "BodyType", "SUV")>
<cfset temp = QuerySetCell(qryData, "VIN", "2FM&K36C&91111111")>
<cfset temp = QuerySetCell(qryData, "Vinstate", "TN")>

<cfdump var="#qryData#" label="1 row of data">

<cfset jsonSample1 = serializeJSON(qrydata, true)>
<cfdump var="#jsonSample1#">


<cfset temp = queryAddRow(qryData)>
<cfset temp = QuerySetCell(qryData, "VehicleNumber", 1)>
<cfset temp = QuerySetCell(qryData, "VehicleYear", 2009)>
<cfset temp = QuerySetCell(qryData, "Make", "FORD")>
<cfset temp = QuerySetCell(qryData, "Model", "EDGE SE")>
<cfset temp = QuerySetCell(qryData, "BodyType", "SUV")>
<cfset temp = QuerySetCell(qryData, "VIN", "2FM&K36C&91111111")>
<cfset temp = QuerySetCell(qryData, "Vinstate", "TN")>

<BR><BR>
<cfdump var="#qryData#" label="2 rows of data">
<cfset jsonSample2 = serializeJSON(qrydata, true)>
<cfdump var="#jsonSample2#">