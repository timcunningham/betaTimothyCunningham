<cfparam name="iMonth" 	default	=	"#datepart("m", now())#">
<cfparam name="iYear"	default	=	"#datepart("yyyy", now())#">
<cfparam name=reportTYpe default="publisher">

<cfset priorMonth = dateAdd("m" ,-1,"#imonth#/1/#iYear#")>
<cfset nextMonth = dateAdd("m" ,1,"#imonth#/1/#iYear#")>

<a href="../panel.cfm">Panel</a>

<cfset priorIMonth = datePart("m", priorMonth)>
<cfset nextIMonth = datePart("m", NextMonth)>
<cfset priorIYear = dateAdd("yyyy" ,-1,"#imonth#/1/#iYear#")>
<cfset nextIYear = dateAdd("yyyy" ,1,"#imonth#/1/#iYear#")>
<cfset priorIYear =  datePart("yyyy", priorIYear)>
<cfset nextIYear =  datePart("yyyy", nextIYear)>

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
		iMonth,
		iYear
	FROM serviceReport SR
	WHERE iYear IN (#iYear#, #evaluate(iyear - 1)#)	
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
	AND EXISTS (SELECT * FROM Publisher P WHERE P.publisherID = SR.publisherID and P.PioInfirm = 0)
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
	<td colspan="10">
	<center><h1>Summary Card #reportType# (#evaluate(iyear-1)# - #iyear#)
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
</tr>
<cfloop query="pubs1">
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
</tr>
</cfloop>
<tr>
	<td colspan=10>
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
	<td><a href="summaryCard.cfm?imonth=#priorIMonth#&iyear=#priorIyear#">Last Year</a></td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td><a href="summaryCard.cfm?imonth=#priorIMonth#&iyear=#nextIyear#">Next Year</a></td>
	
</tr>
</cfoutput>
