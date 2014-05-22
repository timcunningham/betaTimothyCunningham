<cfparam name="iMonth" 	default	=	"#datepart("m", now())#">
<cfparam name="iYear"	default	=	"#datepart("yyyy", now())#">
<cfparam name=reportTYpe default="publisher">
<cfparam name="url.serviceYear" default="#datepart("yyyy", now())#">

<cfset serviceYear = url.serviceYear>
<cfset priorMonth = dateAdd("m" ,-1,"#imonth#/1/#iYear#")>
<cfset nextMonth = dateAdd("m" ,1,"#imonth#/1/#iYear#")>

<a href="../panel.cfm">Panel</a>

<cfset priorIMonth = datePart("m", priorMonth)>
<cfset nextIMonth = datePart("m", NextMonth)>
<cfset priorIYear = dateAdd("yyyy" ,-1,"#imonth#/1/#iYear#")>
<cfset nextIYear = dateAdd("yyyy" ,1,"#imonth#/1/#iYear#")>
<cfset priorIYear =  datePart("yyyy", priorIYear)>
<cfset nextIYear =  datePart("yyyy", nextIYear)>
<cfset finalBooks 		= 0>
<cfset finalBrochure 	= 0>
<cfset finalHours		= 0>
<cfset finalMags 		= 0>
<cfset finalRV 			= 0>
<cfset finalBS 			= 0>
<cfset finalRBC 		= 0>
<cfset finalCount 		= 0>
<cfset finalavghours 	= 0>
<cfset finalavgBS 		= 0>

<cfquery name="pubs1" datasource="#application.DSN#">
	SELECT sum(books) as totBooks,
		sum(brochure) as totBrochure,
		sum(hours) as totHours,
		sum(mags) as totMags,
		sum(rv) as totRV,
		sum(BS) as totBS,
		sum(rbc) as totRBC,
		count(*) as totCount,
		avg(Convert(decimal, hours)) as avgHours,
		avg(Convert(decimal, bs)) as avgBS,
		iMonth,
		iYear
	FROM serviceReport SR
	WHERE serviceYear = '#serviceYear#'	
	<cfif reportType IS "publisher">
	AND aux = 0
	AND regPioneer = 0
	AND specialPioneer =0
	</cfif>
	<cfif reportType IS "AUX">
	AND aux = 1
	</cfif>
	<cfif reportType IS "Pio">
	AND regPioneer = 1
	</cfif>
	<cfif reportType IS "PioInfirm">
	AND regPioneer = 1
	AND EXISTS (SELECT * FROM Publisher P WHERE P.publisherID = SR.publisherID and P.infirmpio = 0)
	</cfif>
	<cfif reportType IS "special">
	AND specialPioneer = 1
	</cfif>
	<cfif reportType IS "ALL">
	AND 1=1
	</cfif>
	<cfif reportType IS "elder">
	AND EXISTS (SELECT * FROM Publisher P WHERE P.publisherID = SR.publisherID and P.elder = 1)
	AND aux = 0
	AND regPioneer = 0
	AND specialPioneer =0
	</cfif>
	<cfif reportType IS "servant">
	AND EXISTS (SELECT * FROM Publisher P WHERE P.publisherID = SR.publisherID and P.servant = 1)
	AND aux = 0
	AND regPioneer = 0
	AND specialPioneer =0
	</cfif>
	<cfif reportType IS "men">
	AND EXISTS (SELECT * FROM Publisher P WHERE P.publisherID = SR.publisherID and P.gender='M')
	AND aux = 0
	AND regPioneer = 0
	AND specialPioneer =0
	</cfif>
	<cfif reportType IS "women">
	AND EXISTS (SELECT * FROM Publisher P WHERE P.publisherID = SR.publisherID and P.gender='F')
	AND aux = 0
	AND regPioneer = 0
	AND specialPioneer =0
	</cfif>
	GROUP BY imonth, iYear
	ORDER BY  iYear ASC, imonth ASC
</cfquery>


<cfoutput>
	
<table cellpadding="10" border="2">
<tr>
	<td colspan="11">
	<center><h1>Summary Card #reportType# #serviceYear#
	</h1>
	</center>
	</td>
</tr>
<tr>
	<td>Month</td>
	<td>Books</td>
	<td>Broch</td>
	<td>Hours</td>
	<td>Mags.</td>
	<td>RVs</td>
	<td>BS</td>
	<td>RBC</td>
	<td>Count</td>
	<td>Avg Hrs</td>
	<td>Avg BS</td>
</tr>
<cfloop query="pubs1">
<cfset finalBooks 		= finalBooks + totBooks>
<cfset finalBrochure 	= finalBrochure + totBrochure>
<cfset finalHours		= finalHours + totHours>
<cfset finalMags 		= finalMags + totMags>
<cfset finalRV 			= finalRV + totRV>
<cfset finalBS 			= finalBS + totBS>
<cfset finalRBC 		= finalRBC + totRBC>
<cfset finalCount 		= finalCount + totCount>
<cfset finalavghours 	= finalavghours + avghours>
<cfset finalavgBS 		= finalavgBS + avgBS>

<tr>
	<td>#pubs1.imonth#/#pubs1.iYear#</td>
	<td>#totBooks#</td>
	<td>#totBrochure#</td>
	<td>#totHours#</td>
	<td>#totMags#</td>
	<td>#totRV#</td>
	<td>#totBS#</td>
	<td>#totRBC#</td>
	<td>#totCount#</td>
	<td>#decimalFormat(avghours)#</td>
	<td>#decimalFormat(avgBS)#</td>
</tr>
</cfloop>
<tr>
	<td>Tot Avg:</td>
	<td>#decimalFormat(finalBooks / pubs1.recordCount)#</td>
	<td>#decimalFormat(finalBrochure / pubs1.recordCount)#</td>
	<td>#decimalFormat(finalHours / pubs1.recordCount)#</td>
	<td>#decimalFormat(finalMags / pubs1.recordCount)#</td>
	<td>#decimalFormat(finalRV / pubs1.recordCount)#</td>
	<td>#decimalFormat(finalBS / pubs1.recordCount)#</td>
	<td>#decimalFormat(finalRBC / pubs1.recordCount)#</td>
	<td>#decimalFormat(finalCount / pubs1.recordCount)#</td>
	<td>#decimalFormat(decimalFormat(finalavghours / pubs1.recordCount))#</td>
	<td>#decimalFormat(decimalFormat(finalavgBS / pubs1.recordCount))#</td>
</tr>


<tr>
	<td colspan=11>
		<a href="summaryCard.cfm?imonth=#imonth#&iyear=#iyear#&reportType=special">Special</a>
		<a href="summaryCard.cfm?imonth=#imonth#&iyear=#iyear#&reportType=Pio">Pioneer</a>
		<a href="summaryCard.cfm?imonth=#imonth#&iyear=#iyear#&reportType=PioInfirm">Pioneer (Not Infirm)</a>
		<a href="summaryCard.cfm?imonth=#imonth#&iyear=#iyear#&reportType=Aux">Aux</a>
		<a href="summaryCard.cfm?imonth=#imonth#&iyear=#iyear#&reportType=publisher">Publisher</a>
		<a href="summaryCard.cfm?imonth=#imonth#&iyear=#iyear#&reportType=Elder">Elder</a>
		<a href="summaryCard.cfm?imonth=#imonth#&iyear=#iyear#&reportType=Servant">Servant</a>
		<a href="summaryCard.cfm?imonth=#imonth#&iyear=#iyear#&reportType=men">Brothers</a>
		<a href="summaryCard.cfm?imonth=#imonth#&iyear=#iyear#&reportType=women">Sisters</a>
		<a href="summaryCard.cfm?imonth=#imonth#&iyear=#iyear#&reportType=All">All</a>
		
	</td>
</tr>
<tr>
	<td><a href="summaryCard.cfm?serviceYear=#serviceYear-1#">Last Year</a></td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td><a href="summaryCard.cfm?serviceYear=#serviceYear+1#">Next Year</a></td>
	
</tr>
</cfoutput>
